ealias sysd='systemctl'

# Output all active and running systemd services (beside the core systemd services)
alias services="systemctl list-units -t service --no-pager --no-legend | grep active | grep -v systemd | grep -v exited | awk '{ print \$1 }'"
