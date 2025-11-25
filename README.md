# Todo-Monolithic 3-Tier Architecture – Terraform Deployment

This repository contains Terraform code to deploy a **Monolithic Todo Application** using a **3‑Tier Architecture** in Azure. The deployment is structured into reusable modules and separate environment configurations.

---

## ✅ Architecture Overview

### **1. Presentation Tier**

* Bastion (secure access)
* Public IP
* Load Balancer (optional)

### **2. Application Tier**

* Virtual Machines
* Virtual Network + Subnets

### **3. Data Tier**

* MSSQL Server
* MSSQL Database
* Key Vault (secrets)
* Storage Account (optional backups)

---

## ✅ Repository Structure

```
.
├── Environment
│   ├── Dev
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── terraform.tfvars
│   │   └── outputs.tf
│   └── Prod
│       ├── main.tf
│       ├── variables.tf
│       ├── terraform.tfvars
│       └── outputs.tf
│
└── Modules
    ├── Bastion
    ├── KV
    ├── LB
    ├── MSSQL_DB
    ├── MSSQL_Server
    ├── PIP
    ├── RG
    ├── STG
    ├── VM
    └── VNET
```

---

## ✅ How to Deploy

### **Step 1 – Select Environment Folder**

```
cd Environment/Dev
```

OR

```
cd Environment/Prod
```

### **Step 2 – Initialize Terraform**

```
terraform init
```

### **Step 3 – Validate**

```
terraform validate
```

### **Step 4 – Review Plan**

```
terraform plan -var-file="terraform.tfvars"
```

### **Step 5 – Deploy Infrastructure**

```
terraform apply -var-file="terraform.tfvars"
```

---

## ✅ Updating the Environment Values

Each environment uses its own **terraform.tfvars** file.

### 🔹 Dev Environment

Modify values inside:

```
Environment/Dev/terraform.tfvars
```

### 🔹 Prod Environment

Modify values inside:

```
Environment/Prod/terraform.tfvars
```

✅ **Only replace values in tfvars — do NOT modify module code.**

---

## ✅ Destroying an Environment

```
terraform destroy -var-file="terraform.tfvars"
```

---

## ✅ Module-Based Deployment Approach

Each module manages an Azure component:

| Module       | Purpose                        |
| ------------ | ------------------------------ |
| RG           | Resource Group creation        |
| VNET         | Virtual Network and subnets    |
| PIP          | Public IP resources            |
| Bastion      | Secure management access       |
| LB           | Load balancer configuration    |
| VM           | Application tier servers       |
| KV           | Store credentials and secrets  |
| MSSQL_Server | SQL Server instance            |
| MSSQL_DB     | Application database           |
| STG          | Storage account and containers |

---

## ✅ Versioning & Remote State (optional recommendation)

Suggested backend:

* Azure Storage Account

Suggested state locking:

* Blob container

---

## ✅ Naming Convention Recommendation

```
<env>-<component>-<sequence>
```

Example:

```
prod-vm-01
dev-kv-01
```

---

## ✅ Notes

✅ The **Dev** and **Prod** environments share the same module structure
✅ Only **tfvars values differ** between environments
✅ This keeps deployments consistent and repeatable

---

## ✅ Future Enhancements

✅ Convert to microservices
✅ Add CI/CD pipeline (GitHub Actions / Azure DevOps)
✅ Add Monitoring + Alerts
✅ Add Application Gateway with WAF

---

## ✅ Contribution Guidelines

* Create feature branches
* Follow module naming conventions
* Run `terraform fmt` before commit

---

## ✅ License

Open for personal and learning use.

---

If you need next:
✅ GitHub Actions pipeline
✅ Azure DevOps YAML
✅ Architecture diagram
✅ Automated destroy protection

Just ask and it will be added.
