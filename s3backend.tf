terraform {
backend "s3" {
bucket = "sourav.srv23-bucket"
key = "sourav.01-network-state"
region = "us-east-1"
}
}
