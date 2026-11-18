# nix
[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ] && source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

# rumba: pair rumba and the coding agent in the same tmux window
[ -f ~/Dev/rumba/integrations/shell/rumba.sh ] && . ~/Dev/rumba/integrations/shell/rumba.sh
