#!/bin/bash
pip install -r /mnt/extra-addons/requirements.txt --break-system-packages --no-warn-script-location

items={{ID}}

for item in "${items[@]}"
do
  odoo -c /etc/odoo/odoo.conf -d odoo -i "$item" --stop-after-init
done
