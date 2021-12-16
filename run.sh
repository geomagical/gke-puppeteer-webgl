# Strict mode.
set -euo pipefail
IFS=$'\n\t'
# Cleanly shut down Xorg when we quit.
trap 'kill $(jobs -p)' EXIT
# Really this is just inserting the correct BusID and could be simpler but this works for now.
nvidia-xconfig --enable-all-gpus --allow-empty-initial-configuration --virtual=1920x1080 --busid=$(nvidia-xconfig --query-gpu-info | grep 'PCI BusID' | sed -r 's/\s*PCI BusID : PCI:(.*)/\1/')
# Start the X server in the background.
# The seat must not be seat0 so it won't try to open the virtual console, which isn't present.
Xorg -seat seat1 :0 &
# Launch the normal command.
"$@"
