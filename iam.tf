resource "aws_iam_role_policy" "s3AdminPolicy" {
    name = "s3AdminPolicy"
    role = aws_iam_role.S3AdminRole.id
    provider = aws.terraformTest
    policy = <<-EOF
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
    provider = aws.terraformTest
    assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "s3.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}


resource "aws_iam_role" "TFAdminRole" {
    name = "TFAdminRole"
    provider = aws.terraformTest
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}



resource "aws_iam_policy_attachment" "test-attach" {
  name       = "test-attachment"
  provider = aws.terraformTest
  roles      = [aws_iam_role.TFAdminRole.name]
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}


