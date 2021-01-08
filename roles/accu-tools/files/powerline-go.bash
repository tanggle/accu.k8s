# Powerline Go
function UPDATE_PROMPT() {
    # Default Modules ###########################################################################
    # PS1=$(powerline-go -error $? -modules venv,user,host,ssh,cwd,perms,git,hg,jobs,exit,root) #
    # Available Modules #########################################################################
    # aws, cwd, docker, docker-context, dotenv, duration, exit, git, gitlite, hg, host, jobs,   #
    # kube, load, newline, nix-shell, node, perlbrew, perms, plenv, root, shell-var, shenv,     #
    # ssh, svn, termtitle, terraform-workspace, time, user, venv, vgo                           #
    #############################################################################################
    PS1=$(powerline-go -mode flat -error $? -modules user,host,kube,cwd,perms,git,jobs,exit,root)
}

if [ "$TERM" != "linux" ] && [ $(which powerline-go) ]; then
    PROMPT_COMMAND="UPDATE_PROMPT; $PROMPT_COMMAND"
fi
