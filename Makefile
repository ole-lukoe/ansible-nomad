
ssh-config:
	vagrant ssh-config > ssh-config

roles/nomad:
	ln -s `pwd`/../ansible-nomad roles/nomad

playbook: roles/nomad ssh-config
	ansible-playbook -i "default," playbook.yml 

clean:
	rm -rf ssh-config
