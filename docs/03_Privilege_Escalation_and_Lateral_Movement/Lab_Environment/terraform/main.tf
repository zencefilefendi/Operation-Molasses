terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# ==========================================
# VPC & Networking (The Shadow Network)
# ==========================================
resource "aws_vpc" "shadow_vpc" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "Shadow-Network-VPC"
    Project = "Operation-Molasses"
  }
}

resource "aws_subnet" "dmz_subnet" {
  vpc_id                  = aws_vpc.shadow_vpc.id
  cidr_block              = "10.10.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "Shadow-DMZ"
  }
}

resource "aws_subnet" "internal_ad_subnet" {
  vpc_id            = aws_vpc.shadow_vpc.id
  cidr_block        = "10.10.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Shadow-Internal-AD"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.shadow_vpc.id
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.shadow_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.dmz_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# ==========================================
# Security Groups (Intentionally Vulnerable)
# ==========================================
resource "aws_security_group" "allow_all_dmz" {
  name        = "allow_all_dmz"
  description = "Intentionally allows RDP, SSH, HTTP for pentesting"
  vpc_id      = aws_vpc.shadow_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ==========================================
# Instances
# ==========================================

# 1. Vulnerable Linux DMZ (Pivot Point)
resource "aws_instance" "linux_dmz" {
  ami           = "ami-0c7217cdde317cfec" # Ubuntu 22.04 LTS (us-east-1)
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.dmz_subnet.id
  vpc_security_group_ids = [aws_security_group.allow_all_dmz.id]

  user_data = <<-EOF
              #!/bin/bash
              apt update
              apt install -y apache2 php libapache2-mod-php
              echo "<?php system(\$_GET['cmd']); ?>" > /var/www/html/vuln.php
              systemctl restart apache2
              EOF

  tags = {
    Name = "Vuln-Linux-DMZ"
  }
}

# 2. Windows Server 2019 (Active Directory Domain Controller)
resource "aws_instance" "windows_dc" {
  ami           = "ami-0bde1eb2c18cb2abe" # Windows Server 2019 Base (us-east-1)
  instance_type = "t2.medium"
  subnet_id     = aws_subnet.internal_ad_subnet.id
  
  # In a real scenario, this would not have a public IP, 
  # but for lab simplicity, we attach the same permissive SG
  vpc_security_group_ids = [aws_security_group.allow_all_dmz.id]

  # User data to automatically install AD DS and promote to Domain Controller
  user_data = <<-EOF
              <powershell>
              Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
              $password = ConvertTo-SecureString "Molasses@2026!" -AsPlainText -Force
              Install-ADDSForest -CreateDnsDelegation:$false -DomainMode Win2012R2 -DomainName "molasses.local" -DomainNetbiosName "MOLASSES" -ForestMode Win2012R2 -InstallDns:$true -SafeModeAdministratorPassword $password -Force:$true
              Restart-Computer -Force
              </powershell>
              EOF

  tags = {
    Name = "Windows-Domain-Controller"
  }
}

# ==========================================
# Outputs
# ==========================================
output "dmz_public_ip" {
  value = aws_instance.linux_dmz.public_ip
  description = "Target this IP first. It hosts a vulnerable PHP web application."
}

output "windows_dc_private_ip" {
  value = aws_instance.windows_dc.private_ip
  description = "Pivot from the DMZ to attack this Active Directory Domain Controller."
}
