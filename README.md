# security-group

Manage a security group in AWS.


## Usage example

```hcl
module "security_group_my_instances" {
  source = "emyller/security-group/aws"
  version = "~> 1.0"
  name = "i-production-web"  # the prefix helps associating to ec2 instances
  vpc_id = module.vpc.id
  ingress_security_groups = {
    "ssh-from-production-vpn" = module.vpn.security_group_id
    "http-from-load-balancer" = module.load_balancer.security_group_id
  }
  allow_self_ingress = true
}
```
