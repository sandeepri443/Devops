#role --- Iaas Cloud eng poweruser role
resource "aws_iam_role" "cloud_eng_sb_poweruser" {
  name                  = "cloud-eng-sb-poweruser"
  path                  = /domainexpert/iaas/"
  description           = "poweruser role for internal app engineers"
  max_session_duration  = 3600
  force_detach_policies  = true
  assume_role_policy     = data.aws_iam_policy_document.policy_trust_base.json


  tags = {
     Name          = "cloud-eng-sb-poweruser"
     Version       = "1.0.0"
     Builder       = "terraform"
     Product       = "Iaas"
     description   = "cloud eng sb Poweruser Role"
    }
  }

data "aws_iam_policy_documnet" "cloud_eng_sb_poweruser_policy-1" {
  statement  {
    sid      = "cloudEngsbPowerUseracceptpolicy"
    effect   = "Allow"
    actions  = [ "ec2:*",
                 "iam:*",
                 "ecs:*",
                "route53:*",
                "logs:*",
                "acm:*",
                "firewal:*",
                "waf:*"
                ]
    resources = ["*"]
    }
    statement {
      sid     = "CloudEngsbpoweruserdenypolicy"
      effect  = "deny"
      actions = [ "ec2"AssignIpv6Addresses",
                  "ecs:Delete*",
                  "batch:DeleteJob*",
                  "rds:Delete*",
                  "Kinesis:Delete*"
                  ]
       resources = ["*"]
      }
    }

resource "aws_iam_policy" "cloud_eng_sb_poweruser_policy-1" {
    name        = "cloud-eng-sb-poweruser-saml-policy-1"
    path        = "/domainExpert/iaas/"
    description = "app poweruser custome policy"

    policy = data.aws_iam_policy_document.cloud_eng_sb_poweruser_policy-1.json
  }

  resources "aws_iam_role_policy_attchment" "cloud_eng_sb_poweruser_policy-1" {
      role        = aws_iam_role.cloud_eng_sb_poweruser.name
      policy_arn  = aws_iam_policy.cloud_eng_sb_poweruser_policy-1.arn
  }













