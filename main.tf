# make ensure that consul must be installed already and the secret and access key will be stored in it
provider "consul" 
{
address = "server ip:8500"
#address = "c11fdd8c206a:8500"
datacenter = "dc1"
}

data "consul_keys" "app" 
{
key {
name = "accesskey"
path = "AWS/accesskey"
}

key {
name = "secretkey"
path = "AWS/secretkey"
}

}
provider "aws"
{
access_key = "${data.consul_keys.app.var.accesskey}"
secret_key = "${data.consul_keys.app.var.secretkey}"
region = "us-east-1"
}

resource "aws_s3_bucket" "b" {
  bucket = "s3bucketname"
  acl    = "private"
  
tags = {
Name = "my bucket"
Environment = "Dev"
}
}
