# DevOps Redmine Infrastructure

## 📌 Description
This project deploys a production-style Redmine infrastructure using Ansible.
The infrastructure includes:
- two application servers
- PostgreSQL database server
- Nginx load balancer
- Dockerized Redmine deployment
- Ansible automation
- Ansible Vault secrets management
- HTTPS access through Cloudflare Tunnel


## 🏗 Infrastructure
```bash
Internet
   ↓
Cloudflare Tunnel
   ↓
Load Balancer (Nginx)
   ↓
--------------------------------
↓                              ↓
App Server 1              App Server 2
(Redmine Docker)          (Redmine Docker)
        ↓
PostgreSQL Database Server
```


## ⚙️ Requirements
Before running the project:
- Ubuntu servers
- Ansible installed locally
- SSH access configured
- Private SSH key
- Docker-compatible servers

Install Ansible:
```bash
sudo apt install ansible
```


## 📁 Project Structure
```bash
.
├── inventory.ini
├── playbook.yml
├── requirements.yml
├── Makefile
├── templates/
│   └── redmine.env.j2
├── group_vars/
│   ├── all.yml
│   └── webservers/
│       └── vault.yml
└── roles/
```


## 🔧 Configuration
Inventory
Edit inventory.ini:
```bash
[webservers]
vm-1 ansible_host=your_host
vm-2 ansible_host=your_host
```

Variables
Edit group_vars/all.yml:
```bash
ansible_user: your_name
ansible_ssh_private_key_file: ~/.ssh/id_rsa

redmine_port: 8080
redmine_app_dir: /opt/redmine

redmine_db_host: your_host_db
redmine_db_port: 5432
redmine_db_name: redmine
redmine_db_user: redmine

redmine_db_password: "{{ vault_redmine_db_password | default('test_password') }}"
redmine_secret_key_base: "{{ vault_redmine_secret_key_base | default('test_secret_key_base') }}"
```


## 🔐 Secrets Management
Create encrypted vault:
```bash
ansible-vault encrypt group_vars/webservers/vault.yml
```

Example vault variables:
```bash
vault_redmine_db_password: your_password
vault_redmine_secret_key_base: your_secret
```


## 📦 Install Dependencies
Install Ansible roles:
```bash
ansible-galaxy install -r requirements.yml -p roles
```

### 🚀 Server Setup
Install Docker and dependencies:
```bash
make setup
```
### 🚀 Deploy Redmine
```bash
make deploy
```


## 🌐 Load Balancer
Nginx load balancer distributes traffic between both application servers.
Example upstream:
```bash
upstream backend {
    server 192.168.0.6:8080;
    server 192.168.0.4:8080;
}
```


## 🗄 Database Setup
Create a dedicated PostgreSQL virtual machine.
Install PostgreSQL:
```bash
sudo apt update
sudo apt install postgresql postgresql-contrib
```

Create Redmine database and user:
```bash
sudo -u postgres psql
```

Inside PostgreSQL shell:
```bash
CREATE USER redmine WITH PASSWORD 'your_password';
CREATE DATABASE redmine OWNER redmine;
GRANT ALL PRIVILEGES ON DATABASE redmine TO redmine;
\q
```

Allow remote connections:
Edit:
```bash
/etc/postgresql/<version>/main/postgresql.conf
```

Uncomment:
```bash
listen_addresses = '*'
```

Edit:
```bash
/etc/postgresql/<version>/main/pg_hba.conf
```

Add:
```bash
host    redmine    redmine    192.168.0.0/24    md5
```

Restart PostgreSQL:
```bash
sudo systemctl restart postgresql
```


## 🔒 HTTPS
HTTPS is provided using:
- Cloudflare Tunnel
- Cloudflare DNS
- Nginx reverse proxy


## ✅ Verification
Check containers:
```bash
docker ps
```

Check Redmine availability:
```bash
curl http://localhost:8080
```

Open application:
```bash
https://your-domain.com
```
