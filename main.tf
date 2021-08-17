resource "aws_security_group" "main" {
  /*
  The Security Group for this module
  */
  vpc_id = var.vpc_id
  name = var.name
  description = var.name

  tags = merge({
    "Name" = var.name
  }, var.tags)
}

resource "aws_security_group_rule" "egress" {
  /*
  Allow all outbound access
  */
  security_group_id = aws_security_group.main.id
  type = "egress"
  cidr_blocks = ["0.0.0.0/0"]
  description = "allow-all"
  protocol = "-1"
  from_port = 0
  to_port = 0
}

resource "aws_security_group_rule" "ingress_cidr_blocks" {
  /*
  Ingress rules for CIDR blocks
  */
  for_each = var.ingress_cidr_blocks
  security_group_id = aws_security_group.main.id
  type = "ingress"
  cidr_blocks = each.value.cidr_blocks
  description = each.key
  protocol = each.value.protocol
  from_port = each.value.port
  to_port = each.value.port == 0 ? 65535 : each.value.port  # 0 means "all"
}

resource "aws_security_group_rule" "ingress_security_groups" {
  /*
  Ingress rules for other security groups
  */
  for_each = var.ingress_security_groups
  security_group_id = aws_security_group.main.id
  type = "ingress"
  source_security_group_id = each.value.security_group_id
  description = each.key
  protocol = each.value.protocol
  from_port = each.value.port
  to_port = each.value.port == 0 ? 65535 : each.value.port  # 0 means "all"
}
