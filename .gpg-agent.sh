GPG_ENV=$HOME/.gnupg/environment
COMMAND="/usr/bin/gpg-agent --daemon"

function start_agent {
     echo "Initialising new GPG agent..."
     $COMMAND > ${GPG_ENV}
     echo succeeded
     chmod 600 ${GPG_ENV}
     . ${GPG_ENV} > /dev/null
}

# Source GPG settings, if applicable

if [ -f "${GPG_ENV}" ]; then
     . ${GPG_ENV} > /dev/null
     GPG_AGENT_PID=$(echo ${GPG_AGENT_INFO} | cut -d: -f2)
     ps -ef | grep ${GPG_AGENT_PID} | grep "${COMMAND}$" > /dev/null || {
         start_agent;
     }
else
     start_agent;
fi

