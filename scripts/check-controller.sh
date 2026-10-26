#!/usr/bin/env bash
set -u

fouten=0

check() {
  local naam="$1"
  shift

  if "$@" >/dev/null 2>&1; then
    printf 'OK   %s\n' "$naam"
  else
    printf 'FOUT %s\n' "$naam"
    fouten=1
  fi
}

echo "Controller-check $(date '+%Y-%m-%d %H:%M')"

check "aws CLI geinstalleerd" command -v aws
check "terraform geinstalleerd" command -v terraform
check "ansible geinstalleerd" command -v ansible
check "AWS-credentials geldig" aws sts get-caller-identity
check "sleutel aws-lab in de agent" sh -c 'ssh-add -l | grep -q aws-lab'
check "GitHub bereikbaar" sh -c 'ssh -T git@github-school 2>&1 | grep -q successfully'

if [ "$fouten" -eq 0 ]; then
  echo "Klaar voor de sessie."
else
  echo "Los eerst de FOUT-regels op."
  echo "Credentials verlopen? Plak ze opnieuw uit AWS Details."
fi

exit "$fouten"
