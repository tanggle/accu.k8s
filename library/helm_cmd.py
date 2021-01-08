#!/usr/bin/python
class HelmManager(object):

    def __init__(self, module):

        self.module = module

        self.helm = module.params.get('path')
        bin_opt_list = ["/usr/local/bin/","/usr/bin/"]
        if self.helm is None:
            self.helm =  module.get_bin_path('helm', True, bin_opt_list)

        self.base_cmd = self.helm

        self.name = module.params.get('name')
        self.version = module.params.get('version')
        self.release = module.params.get('release')
        self.namespace = module.params.get('namespace')
        self.update_cache = module.params.get('update_cache')
        self.force = module.params.get('force')
        self.wait = module.params.get('wait')
        self.options = [f.strip() for f in module.params.get('options') or []]

        if self.update_cache:
            self.updateCache()

    def _execute(self, cmd):
        changed = False
        args = self.str_concat(self.base_cmd, cmd)
        try:
            rc, out, err = self.module.run_command(args,use_unsafe_shell=True)
            if rc != 0:
                self.module.fail_json(
                    msg='error running helm (%s) command (rc=%d), out=\'%s\', err=\'%s\'' % (' '.join(args), rc, out, err))
            else:
                changed = True
        except Exception as exc:
            self.module.fail_json(
                msg='error running helm (%s) command: %s' % (' '.join(args), str(exc)))
        
        return out.splitlines(), changed

    def _execute_nofail_str(self, cmd):
        args = self.str_concat(self.base_cmd, cmd)
        rc, out, err = self.module.run_command(args,use_unsafe_shell=True)
       
        if rc != 0:
            return None
        return out.splitlines()

    def install(self, latest=False):

        if not self.force and not latest and self.exists(all=False, ver=True):
            return ['release already exists!'], False

        if self.exists(all=False, ver=False):
            cmd = "upgrade"
        else:
            cmd = "install"

        if self.release:
            cmd = self.str_concat(cmd,self.release)

        if self.name:
            cmd = self.str_concat(cmd,self.name)

        if self.namespace:
            cmd = self.str_concat(cmd,"--namespace")
            cmd = self.str_concat(cmd,self.namespace)

        if self.version and not latest:
            cmd = self.str_concat(cmd,"--version")
            cmd = self.str_concat(cmd,self.version)

        if self.options:
            for option in self.options:
                cmd = self.str_concat(cmd,option)

        cmd = self.str_concat(cmd,"--create-namespace")

        if self.wait:
            cmd = self.str_concat(cmd,"--wait")
        
        return self._execute(cmd)


    def delete(self, purged=False):

        if not self.exists(all=True, ver=False):
            return ['release does not exist!'], False

        cmd = "uninstall"

        if self.release:
            cmd = self.str_concat(cmd, self.release)

        if not purged:
            cmd = self.str_concat(cmd,"--keep-history")

        cmd = self.str_concat(cmd, "-n")
        cmd = self.str_concat(cmd, self.namespace)

        return self._execute(cmd)
        

    def exists(self, all=True, ver=False):

        cmd = "list"

        if all:
            cmd = self.str_concat(cmd, "--all")

        cmd = self.str_concat(cmd, "-n")
        cmd = self.str_concat(cmd, self.namespace)

        cmd = self.str_concat(cmd, '| grep -w')
        cmd = self.str_concat(cmd, self.release)

        if ver:
            cmd = self.str_concat(cmd, '| grep -w')
            cmd = self.str_concat(cmd, self.version)

        result = self._execute_nofail_str(cmd)
        if result == None:
            return 
        return True

    def updateCache(self):
        cmd = "repo update"
        result, changed = self._execute(cmd)

    def str_concat(self, first, second):
        return first+" "+second

def main():

    module = AnsibleModule(
        argument_spec=dict(
            name=dict(type='str', required=True),
            version=dict(type='str', required=False),
            release=dict(type='str', required=True),
            namespace=dict(type='str', required=True),
            state=dict(default='present', choices=['present', 'absent', 'latest', 'purged']),
            path=dict(type='str', required=False),
            update_cache=dict(type='bool', required=False),
            force=dict(type='bool', required=False),
            wait=dict(type='bool', required=False),
            options=dict(type='list', required=False)
            )
        )

    changed = False

    manager = HelmManager(module)
    state = module.params.get('state')

    if state == 'present':
        result, changed = manager.install()

    elif state == 'absent':
        result, changed = manager.delete()

    elif state == 'latest':
        result, changed = manager.install(latest=True)

    elif state == 'purged':
        result, changed = manager.delete(purged=True)

    else:
        module.fail_json(msg='unrecognized state %s.' % state)

    module.exit_json(changed=changed, msg='success: %s' % (' '.join(result)))


from ansible.module_utils.basic import * 
if __name__ == '__main__':
    main()
