# Update landing site
ansible-playbook -i ec2.py -u ec2-user --private-key <amazon.pem> update_landing.yml
