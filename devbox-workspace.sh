# Multi-workspace support for Devbox
#
# Installation: Copy this file to your machine, then set alias in bashrc: alias dbs='/home/user/workspace/devbox/script/devbox-workspace.sh'
# Usage: Run "dbs workspace_name" to activate a devbox workspace and access its shell

DEVBOX_WORKSPACE=/home/user/workspace/devbox

if [ ! -d $DEVBOX_WORKSPACE/$1 ]; then
	mkdir -p $DEVBOX_WORKSPACE/$1
fi
if [ ! -f $DEVBOX_WORKSPACE/$1/devbox.json ]; then
	devbox init $DEVBOX_WORKSPACE/$1
	DB_COMMAND="alias db='f() { if [[ \$1 && \"add list rm update\" =~ \$1 ]]; then command devbox \"\$@\" -c \"$DEVBOX_WORKSPACE/$1/devbox.json\"; else command devbox \"\$@\"; fi }; f'"
	echo $DB_COMMAN\D
	jq --arg cmd "$DB_COMMAND" '.shell.init_hook += [$cmd]' "$DEVBOX_WORKSPACE/$1/devbox.json" >"$DEVBOX_WORKSPACE/$1/devbox-tmp.json"
	mv $DEVBOX_WORKSPACE/$1/devbox-tmp.json $DEVBOX_WORKSPACE/$1/devbox.json
fi
devbox shell -c $DEVBOX_WORKSPACE/$1
