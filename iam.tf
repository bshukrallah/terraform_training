resource "aws_iam_role_policy" "s3AdminPolicy" {
    name = "s3AdminPolicy"
    role = aws_iam_role.S3AdminRole.id
    description = "Grant S3 Admin Rights"

    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1610557694422",
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role" "S3AdminRole" {
    name = "S3AdminRole"
    assume_role_policy = aws_iam_role_policy.s3AdminPolicy.id
}