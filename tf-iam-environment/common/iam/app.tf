#role ---app poweruser role
resource "aws_iam_role" "app_poweruser" {
  name                  = "app-poweruser"
  path                  = /domainexpert/app/"
  description           = "poweruser role for internal app engineers"
  max_session_duration  = 3600
  force_detach_policies  = true
  assume_role_policy     = data.aws_iam_policy_document.policy_trust_base.json


  tags = {
     Name          = "app-poweruser"
     Version       = "1.0.0"
     Builder       = "terraform"
     Product       = "app"
     description   = "app Poweruser Role"
  }
  }



data "aws_iam_policy_document" "app_poweruser" {
  statement {
    sid     = "APPPoweruser"
    effect  = "Allow"
    actions = [
      "ec2:Describe*",
      "ec2:CreateTags",
      "cloudwatch:listMetrics",
      "ec2:Descripbevpcs",
      "ec2:DEscribeTags"
    ]
    resources = ["*"]
  }
}

  statement {
    sid    = "EKSAdmin"
    effect = "Allow"
    actions = [
       "eks:AccessKubernetesApi",
       "eks:CreateCluster"
      ]
      resources = ["arn:aws:eks:us-west-2:0123456789191:*"]
     }
  }

  resource "aws_iam_policy" "app_poweruser_1" {
    name        = "app-poweruser"
    path        = "/domainExpert/app/"
    description = "app poweruser custome policy"

    policy = data.aws_iam_policy_document.app_poweruser.json
  }

  resources "aws_iam_role_policy_attchment" "app_poweruser_1" {
      role        = aws_iam_role.app_poweruser.name
      policy_arn  = aws_iam_policy.app_poweruser_1.arn
  }

  resources "aws_iam_role_policy_attachmnet" "app_poweruser_2" {
     role         = aws_iam_role.app_poweruser.name
     policy_arn   = "arn:aws:iam:aws:policy/AmazonEC2ReadOnlyAccess"
  }  

      
  

















