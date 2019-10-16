terraform-aws-efs
=================

Terraform module to create EFS volume and mount targets.


Example usage:
-----

```hcl
module "efs" {
  source = "github.com/immanuelpotter/terraform-aws-efs?ref=master"
  private_subnet_a = "${var.private_subnet_a}"
  private_subnet_b = "${var.private_subnet_b}"
  private_subnet_c = "${var.private_subnet_c}"
  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
```


And for specific SGs to be able to access the mountpoints:
```hcl
module "efs_bamboo_1" {
  source = "github.com/immanuelpotter/terraform-aws-efs?ref=master"
  private_subnet_a = "${element(split(",",module.vpc.subnets_private),0)}"
  private_subnet_b = "${element(split(",",module.vpc.subnets_private),1)}"
  security_groups  = ["${module.sec_group1.sg_id}","${module.sec_group2.sg_id}"]

  tags = {
    Terraform     = "true"
    Environment   = "dev"
  }
}
```

Authors
-------

Original module managed by [Smartbrood LLC](https://github.com/Smartbrood).

Forked by [Immanuel Potter](https://githib.com/immanuelpotter)

License
-------

Apache 2 Licensed. See LICENSE for full details.
