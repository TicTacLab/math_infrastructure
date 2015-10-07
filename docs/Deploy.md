# Update landing site
ansible-playbook -i ec2.py -u ec2-user --private-key <amazon.pem> update_landing.yml


# Demo 3
ansible-playbook -i ec2.py -u ubuntu --private-key <amazon.pem> -e @group_vars/demo3.yml demo3/site.yml