# Policy: S3 files from EC2
data "aws_iam_policy_document" "customer_to_s3_interfaces_bucket" {
  statement {
    sid     = "ListBucket"
    effect  = "Allow"
    actions = ["s3:ListBucket", "s3:GetBucketLocation"]

    resources = [
      "arn:aws:s3:::${local.s3_interfaces_bucket}",
      "arn:aws:s3:::${local.s3_origination_bucket}",
      "arn:aws:s3:::${local.s3_insurance_bucket}",
      "arn:aws:s3:::${local.s3_bank_bucket}",
    ]
  }

  statement {
    sid     = "ReadBucket"
    effect  = "Allow"
    actions = ["s3:List*", "s3:Get*"]

    resources = [
      "arn:aws:s3:::${local.s3_interfaces_bucket}/*",
      "arn:aws:s3:::${local.s3_origination_bucket}/*",
      "arn:aws:s3:::${local.s3_insurance_bucket}/*",
      "arn:aws:s3:::${local.s3_bank_bucket}/*",
    ]
  }

  statement {
    sid     = "PutUpload"
    effect  = "Allow"
    actions = ["s3:Put*", "s3:AbortMultipartUpload"]

    resources = [
      "arn:aws:s3:::${local.s3_interfaces_bucket}/upload/*",
      "arn:aws:s3:::${local.s3_origination_bucket}/upload/*",
      "arn:aws:s3:::${local.s3_insurance_bucket}/upload/*",
      "arn:aws:s3:::${local.s3_bank_bucket}/upload/*",
    ]
  }
}

# Policy for S3 bucket access
resource "aws_iam_policy" "customer_to_s3_interfaces_bucket" {
  name_prefix = "cust_${var.customer_name}_iam_s3_interfaces_"
  description = "S3 access for ${var.customer_name} interface access"
  policy      = "${data.aws_iam_policy_document.customer_to_s3_interfaces_bucket.json}"
}

resource "aws_iam_user" "customer_interface_user" {
  name = "cust_${var.customer_name}_interface_user"
}

resource "aws_iam_user_policy_attachment" "customer_to_s3_interfaces_bucket" {
  user       = "${aws_iam_user.customer_interface_user.name}"
  policy_arn = "${aws_iam_policy.customer_to_s3_interfaces_bucket.arn}"
}

resource "aws_iam_access_key" "customer_access_key" {
  user = "${aws_iam_user.customer_interface_user.name}"
}
