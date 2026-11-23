# AWS Modular Web Infrastructure with Terraform

A reusable, modular Infrastructure-as-Code (IaC) project built with **Terraform** on **AWS**. This project provisions multiple EC2 web servers with dynamically generated Security Groups, automated AMI discovery, strict input validation, and structured outputs.

---

## Architecture Overview

```text
[ Root Module ]
 ├── datasource.tf ──► Fetches latest Ubuntu 24.04 AMI dynamically
 ├── locals.tf     ──► Standardizes naming prefixes & common tags
 ├── variable.tf   ──► Enforces map(object) schemas & environment validation
 └── main.tf       ──► Loops over servers with for_each
       │
       ▼
[ Child Module: ./module/web-node ]
 ├── aws_security_group ──► Dynamic ingress rules + create_before_destroy lifecycle
 └── aws_instance       ──► EC2 instance attached to dynamic Security Group
```

---

## Key Terraform Features Used

- **Reusable Child Module (`./module/web-node`):** Encapsulates EC2 and Security Group creation so multiple environments or server tiers can reuse the same blueprint.
- **`for_each` over `map(object({...}))`:** Safely provisions and scales independent nodes (`frontend`, `backend-api`) without list index-shifting issues.
- **Dynamic Blocks:** Generates TCP ingress firewall rules dynamically from a list of ports (`allowed_ports`).
- **Data Sources (`aws_ami`):** Automatically queries Canonical's official AWS account (`099720109477`) for the latest Ubuntu 24.04 LTS AMI in the target region.
- **Lifecycle Management:** Uses `create_before_destroy = true` on Security Groups for zero-downtime replacements.
- **Input Validation & Locals:** Validates allowed environments (`dev`, `staging`, `prod`) and merges standardized resource tags via `merge()`.

---

## Project Structure

```text
.
├── providers.tf          # AWS provider configuration
├── variable.tf           # Root input variables, type constraints & validation
├── terraform.tfvars      # Environment-specific server configurations
├── locals.tf             # Computed naming prefixes & common tags
├── datasource.tf         # Dynamic Ubuntu AMI lookup
├── main.tf               # Root module calling ./module/web-node with for_each
├── outputs.tf            # Formatted map of deployed Instance IDs, IPs & SG IDs
└── module/
    └── web-node/         # Reusable child module
        ├── variable.tf
        ├── main.tf
        └── output.tf
```

---

## How to Use

1. **Initialize Terraform & register modules:**
   ```bash
   terraform init
   ```

2. **Format and validate configuration:**
   ```bash
   terraform fmt -recursive
   terraform validate
   ```

3. **Preview execution plan:**
   ```bash
   terraform plan
   ```

4. **Deploy infrastructure:**
   ```bash
   terraform apply
   ```

5. **Clean up resources:**
   ```bash
   terraform destroy
   ```
