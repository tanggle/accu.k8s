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
        self.url = module.params.get('url')
        self.username = module.params.get('username')
        self.password = module.params.get('password')
        self.update_cache = module.params.get('update_cache')
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

    def add(self):

        if self.exists(url=False):
            return ['repo already exists!'], False

        cmd = "repo add"
        cmd = self.str_concat(cmd,self.name)
        
        if self.url:
            cmd = self.str_concat(cmd,self.url)
        else:
            self.module.fail_json(msg='url is required!')


        if self.username:
            cmd = self.str_concat(cmd,"--username")
            cmd = self.str_concat(cmd,self.username)

        if self.password:
            cmd = self.str_concat(cmd,"--password")
            cmd = self.str_concat(cmd,self.password)

        if self.options:
            for option in self.options:
                cmd = self.str_concat(cmd,option)

        return self._execute(cmd)
        


    def remove(self):

        if not self.exists(url=False):
            return ['repo does not exist!'], False

        cmd = "repo remove"
        cmd = self.str_concat(cmd, self.name)

        return self._execute(cmd)
        

    def exists(self, url=False):

        cmd = "repo list"
        
        cmd = self.str_concat(cmd, '| grep -w')
        cmd = self.str_concat(cmd, self.name)

        if url:
            cmd = self.str_concat(cmd, '| grep -w')
            cmd = self.str_concat(cmd, self.url)

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
            url=dict(type='str', required=False),
            username=dict(type='str', required=False),
            password=dict(type='str', required=False),
            state=dict(default='present', choices=['present', 'absent']),
            update_cache=dict(type='bool', required=False),
            options=dict(type='list', required=False)
            )
        )

    changed = False

    manager = HelmManager(module)
    state = module.params.get('state')

    if state == 'present':
        result, changed = manager.add()

    elif state == 'absent':
        result, changed = manager.remove()

    else:
        module.fail_json(msg='unrecognized state %s.' % state)

    module.exit_json(changed=changed, msg='success: %s' % (' '.join(result)))


from ansible.module_utils.basic import * 
if __name__ == '__main__':
    main()

