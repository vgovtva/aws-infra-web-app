# TODO: Put vpc_id, NAT GW Route Table ID, and other exported variables to S3 backend bucket

resource "aws_s3_bucket_object" "output_variables" {
  bucket = var.output_bucket
  key = "${var.output_bucket_key_prefix}/network_output.json"
  content = jsonencode({
    vpc_id = local.vpc_id
  })
}
