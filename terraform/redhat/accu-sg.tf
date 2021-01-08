# Kubernetes Security Groups

resource "aws_security_group" "kubernetes" {
  name = "k8s-${var.aws_cluster_name}-securitygroup"

  tags = merge(var.default_tags, map(
    "Name", "k8s-${var.aws_cluster_name}-securitygroup"
  ))
}

# ALLOW ALL TRAFFICS BETWEEN EC2 INSTANCES IN DEFAULT VPC
resource "aws_security_group_rule" "allow-all-ingress" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["172.31.0.0/16"]
  security_group_id = aws_security_group.kubernetes.id
}

resource "aws_security_group_rule" "allow-all-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["172.31.0.0/16", "0.0.0.0/0"]
  security_group_id = aws_security_group.kubernetes.id
}

resource "aws_security_group_rule" "allow-ssh-connection" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.kubernetes.id
}

# Add K8s API Endpoint Port
resource "aws_security_group_rule" "allow-k8s-apiserver" {
  type              = "ingress"
  from_port         = 6443
  to_port           = 6443
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.kubernetes.id
}

resource "aws_security_group_rule" "allow-k8s-ingress-p" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.kubernetes.id
}

resource "aws_security_group_rule" "allow-k8s-ingress-s" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.kubernetes.id
}
