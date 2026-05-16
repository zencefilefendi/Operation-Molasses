# 🕸️ The Shadow Network (Cyber Polygon)

Reading about Active Directory exploitation is meaningless without a Domain Controller to attack. **The Shadow Network** is an Infrastructure-as-Code (IaC) module that uses Terraform to spin up a fully functional, vulnerable corporate network inside your AWS account in under 5 minutes.

## 🏗️ Architecture

When you deploy this module, Terraform provisions the following in an isolated Virtual Private Cloud (VPC):
1. **The DMZ (Ubuntu Linux):** A web server exposed to the public internet hosting a vulnerable PHP application (Command Injection). This is your initial foothold.
2. **The Internal Network (Windows Server 2019):** An Active Directory Domain Controller (molasses.local) hidden in a private subnet.

**The Objective:**
Compromise the DMZ web server, escalate privileges, establish a pivot (e.g., using Chisel or SSH tunneling), and laterally move into the internal network to compromise the Domain Controller.

---

## 🚀 Deployment Instructions

### Prerequisites
- An active AWS Account.
- Terraform installed on your machine.
- AWS CLI configured with your credentials.

### Execution

1. Navigate to the Terraform directory:
   cd docs/03_Privilege_Escalation_and_Lateral_Movement/Lab_Environment/terraform

2. Initialize Terraform (downloads the AWS provider):
   terraform init

3. Review the deployment plan:
   terraform plan

4. Deploy the Shadow Network:
   terraform apply -auto-approve

*Note: The Windows Server takes about 5-10 minutes to finish installing Active Directory and reboot.*

### 🛑 Destruction (CRITICAL)
AWS resources cost money. When you have finished your exploitation practice, do not forget to destroy the environment.

terraform destroy -auto-approve

