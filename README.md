### Hexlet tests and linter status:
[![Actions Status](https://github.com/VeraVLVlas/devops-for-developers-project-76/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/VeraVLVlas/devops-for-developers-project-76/actions)

# Ansible Server Setup

## 📌 Description

This project prepares servers using Ansible:
- installs pip
- installs Python Docker library
- installs Docker Engine

---


## ⚙️ Requirements

**Before running the project, make sure you have:**
- Ansible installed
- SSH access to servers
- Private SSH key

**Install Ansible:**
```bash
sudo apt install ansible
```


## 📁 Project Structure
├── inventory.ini
├── playbook.yml
├── requirements.yml
├── Makefile
└── group_vars/
  └── all.yml


## 🔧 Configuration

**Inventory**
Edit inventory.ini and specify your servers:
```ini
[webservers]
vm1 ansible_host=<PUBLIC_IP_1>
vm2 ansible_host=<PUBLIC_IP_2>
```

**Variables**
Edit group_vars/all.yml:
```yaml
ansible_user: ubuntu
ansible_ssh_private_key_file: ~/.ssh/id_rsa
```


## 📦 Install Dependencies
```bash
ansible-galaxy install -r requirements.yml
ansible-galaxy collection install -r requirements.yml
```


## 🚀 Run Playbook
```bash
make setup
```


## ✅ Verify
**Check Docker installation:**
```bash
docker ps
```

**Check Python Docker module:**
```bash
pip show docker
```