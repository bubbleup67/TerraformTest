resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = "vpc-b81aacd0"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.myIp}"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_s3_bucket" "example" {
  # NOTE: S3 bucket names must be unique across _all_ AWS accounts, so
  # this name must be changed before applying this example to avoid naming
  # conflicts.
  bucket = "johnray-terraform-bucket"
  acl    = "private"
}
resource "aws_instance" "example" {
  ami           = "ami-f63b1193"
  instance_type = "t2.micro"
  key_name = "JR-East2"
  security_groups = ["${aws_security_group.allow_all.name}"]
  
  # Tells Terraform that this EC2 instance must be created only after the
  # S3 bucket has been created.
  depends_on = ["aws_s3_bucket.example"]
  
  provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }
  
  tags {
    Name = "HelloWorld"
  }
}
resource "aws_eip" "ip" {
  instance = "${aws_instance.example.id}"
}