setup:
	ansible-playbook -i inventory.ini playbook.yml --tags setup --ask-vault-pass

deploy:
	ansible-playbook -i inventory.ini playbook.yml --tags deploy --ask-vault-pass

encrypt:
	ansible-vault encrypt group_vars/webservers/vault.yml
