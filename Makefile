setup:
	ansible-playbook -i inventory.ini playbook.yml --tags setup

deploy:
	ansible-playbook -i inventory.ini playbook.yml --tags deploy
