# Policy: S3 files from EC2
data "aws_iam_policy_document" "customer_to_s3_interfaces_bucket" {
  statement {
    sid     = "ListBucket"
    effect  = "Allow"
    actions = ["s3:ListBucket", "s3:GetBucketLocation"]

    resources = [
      "arn:aws:s3:::${local.s3_interfaces_bucket}",
    ]
  }

  statement {
    sid     = "ReadBucket"
    effect  = "Allow"
    actions = ["s3:List*", "s3:Get*"]

    resources = [
      "arn:aws:s3:::${local.s3_interfaces_bucket}/*",
    ]
  }

  statement {
    sid     = "PutUpload"
    effect  = "Allow"
    actions = ["s3:Put*", "s3:AbortMultipartUpload"]

    resources = [
      "arn:aws:s3:::${local.s3_interfaces_bucket}/upload/*",
    ]
  }
}

# Policy: S3 files from EC2
data "aws_iam_policy_document" "origination_to_s3_interfaces_bucket" {
  statement {
    sid     = "ListBucket"
    effect  = "Allow"
    actions = ["s3:ListBucket", "s3:GetBucketLocation"]

    resources = [
      "arn:aws:s3:::${local.s3_origination_bucket}",
    ]
  }

  statement {
    sid     = "ReadBucket"
    effect  = "Allow"
    actions = ["s3:List*", "s3:Get*"]

    resources = [
      "arn:aws:s3:::${local.s3_origination_bucket}/*",
    ]
  }

  statement {
    sid     = "PutUpload"
    effect  = "Allow"
    actions = ["s3:Put*", "s3:AbortMultipartUpload"]

    resources = [
      "arn:aws:s3:::${local.s3_origination_bucket}/upload/*",
    ]
  }
}

# Policy: S3 files from EC2
data "aws_iam_policy_document" "insurance_to_s3_interfaces_bucket" {
  statement {
    sid     = "ListBucket"
    effect  = "Allow"
    actions = ["s3:ListBucket", "s3:GetBucketLocation"]

    resources = [
      "arn:aws:s3:::${local.s3_insurance_bucket}",
    ]
  }

  statement {
    sid     = "ReadBucket"
    effect  = "Allow"
    actions = ["s3:List*", "s3:Get*"]

    resources = [
      "arn:aws:s3:::${local.s3_insurance_bucket}/*",
    ]
  }

  statement {
    sid     = "PutUpload"
    effect  = "Allow"
    actions = ["s3:Put*", "s3:AbortMultipartUpload"]

    resources = [
      "arn:aws:s3:::${local.s3_insurance_bucket}/upload/*",
    ]
  }
}

# Policy: S3 files from EC2
data "aws_iam_policy_document" "bank_to_s3_interfaces_bucket" {
  statement {
    sid     = "ListBucket"
    effect  = "Allow"
    actions = ["s3:ListBucket", "s3:GetBucketLocation"]

    resources = [
      "arn:aws:s3:::${local.s3_bank_bucket}",
    ]
  }

  statement {
    sid     = "ReadBucket"
    effect  = "Allow"
    actions = ["s3:List*", "s3:Get*"]

    resources = [
      "arn:aws:s3:::${local.s3_bank_bucket}/*",
    ]
  }

  statement {
    sid     = "PutUpload"
    effect  = "Allow"
    actions = ["s3:Put*", "s3:AbortMultipartUpload"]

    resources = [
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

# Policy for S3 bucket access
resource "aws_iam_policy" "customer_to_s3_origination_bucket" {
  name_prefix = "orig_${var.customer_name}_iam_s3_origination_"
  description = "S3 access for ${var.customer_name} origination access"
  policy      = "${data.aws_iam_policy_document.customer_to_s3_interfaces_bucket.json}"
}

resource "aws_iam_user" "customer_origination_user" {
  name = "orig_${var.customer_name}_origination_user"
}

resource "aws_iam_user_policy_attachment" "customer_to_s3_origination_bucket" {
  user       = "${aws_iam_user.customer_origination_user.name}"
  policy_arn = "${aws_iam_policy.customer_to_s3_interfaces_bucket.arn}"
}

resource "aws_iam_access_key" "origination_access_key" {
  user = "${aws_iam_user.customer_origination_user.name}"
}

# Policy for S3 bucket access
resource "aws_iam_policy" "customer_to_s3_insurance_bucket" {
  name_prefix = "ins_${var.customer_name}_iam_s3_insurance_"
  description = "S3 access for ${var.customer_name} insurance access"
  policy      = "${data.aws_iam_policy_document.customer_to_s3_interfaces_bucket.json}"
}

resource "aws_iam_user" "customer_insurance_user" {
  name = "ins_${var.customer_name}_insurance_user"
}

resource "aws_iam_user_policy_attachment" "customer_to_s3_insurance_bucket" {
  user       = "${aws_iam_user.customer_insurance_user.name}"
  policy_arn = "${aws_iam_policy.customer_to_s3_interfaces_bucket.arn}"
}

resource "aws_iam_access_key" "insurance_access_key" {
  user = "${aws_iam_user.customer_insurance_user.name}"
}

# Policy for S3 bucket access
resource "aws_iam_policy" "customer_to_s3_bank_bucket" {
  name_prefix = "bank_${var.customer_name}_iam_s3_bank_"
  description = "S3 access for ${var.customer_name} bank access"
  policy      = "${data.aws_iam_policy_document.customer_to_s3_interfaces_bucket.json}"
}

resource "aws_iam_user" "customer_bank_user" {
  name = "bank_${var.customer_name}_bank_user"
}

resource "aws_iam_user_policy_attachment" "customer_to_s3_bank_bucket" {
  user       = "${aws_iam_user.customer_bank_user.name}"
  policy_arn = "${aws_iam_policy.customer_to_s3_interfaces_bucket.arn}"
}

resource "aws_iam_access_key" "bank_access_key" {
  user = "${aws_iam_user.customer_bank_user.name}"
}
