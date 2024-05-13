# Deprecated

New testbed repo: https://github.com/named-data/testbed

# NDN_Ansible
Ansible management for NDN Testbed

To do the whole thing:
ansible-playbook -i testbedInventory testbed.yml

To do just nlsr on LIP6 and BERN
ansible-playbook -i testbedInventory --tags="nlsr" --limit="LIP6,BERN" testbed.yml


To slow the process down if you are having trouble with multiple repeated logins
to a site (sometimes firewalls block if they see too many attempts):
./echoY.sh | ansible-playbook --step -i testbedInventory testbed.yml

The echoY.sh script echos a Y to the ansible-playbook process every 30 seconds.


