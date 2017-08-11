# NDN_Ansible
Ansible management for NDN Testbed

To do the whole thing:
ansible-playbook -i testbedInventory testbed.yml

To do just nlsr on LIP6 and BERN
ansible-playbook -i testbedInventory --tags="nlsr" --limit="LIP6,BERN" testbed.yml
