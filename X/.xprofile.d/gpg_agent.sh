GPG_AGENT_INFO="${HOME}/.gnupg/gpg-agent.info"
pgrep -u "${USER}" gpg-agent >/dev/null 2>&1
if [ $? -ne 0 ]; then
  gpg-agent --enable-ssh-support --daemon --write-env-file "${GPG_AGENT_INFO}"
fi

source "${GPG_AGENT_INFO}"
export GPG_AGENT_INFO
export SSH_AUTH_SOCK
export SSH_AGENT_PID
