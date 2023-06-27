####domain-cloud-eng-sb-poweruser-jump role
resource "aws_iam_role" "cloud_eng_sb_poweruser_jump" {
  name                  = "cloud-eng-sb-poweruser-jump"
  path                  = /domainexpert/iaas/"
  description           = "Allow STS to cloud eng sb poweruser roles"
  max_session_duration  = 3600
  force_detach_policies  = true
  assume_role_policy     = data.aws_iam_policy_document.core_saml_trust.json


  tags = {
     Name          = "cloud-eng-sb-poweruser"
     Version       = "1.0.0"
     Builder       = "terraform"
     Product       = "Iaas"
     description   = "cloud eng sb Poweruser jump Role"
    }
  }

data "aws_iam_policy_document" "cloud_eng_sb_poweruser_jump" {
   statement {
     sid     = "CloudEngAdminSTS"
     effect  = "Allow"
     actions = ["sts:AssumeRole"]
     resources = [
       "arn:aws:iam::*role/domain/iaas/cloud-eng-sb-poweruser"
     ]
   }
} 


resources "aws_iam_policy" "cloud_eng_sb_poweruser_jump" {
   name        = "cloud-eng-sb-poweruser-sts"
   path        = "/domain/iaas/"
   description = "cloud eng sb poweruser sts policy"


   policy = data.aws_iam_policy_document.cloud_eng_sb_poweruser_jump.json
  }


  resources "aws_iam_role_policy_attachment" "cloud_eng_sb_poweruser_jump" {
    role         = aws_iam_role.cloud_eng_sb_poweruser_jump.name
    policy_arn   = aws_iam_policy.cloud_eng_sb_poweruser_jump.arn
  }

  resources "aws_iam_role_policy_attachment" "cloud_eng_sb_poweruser_jump_1" {
    role         = aws_iam_role.cloud_eng_sb_poweruser_jump.name
    policy_arn   = "arn:aws:iam::aws:policy/ReadOnlyACcess"
  }












