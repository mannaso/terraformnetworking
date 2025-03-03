resource "aws_vpc" "sourav_vpc" {
 cidr_block = "10.0.0.0/16" # Mandatory: Defines the IP range for the VPC
 tags = {
 Name = "my-vpc"
 }
}

resource "aws_subnet" "sourav_subnet" {
  vpc_id            = aws_vpc.sourav_vpc.id  # Reference the imported VPC/one can reference to the variable as well aws_vpc.sourav_vpc.id
  cidr_block        = "10.0.1.0/24"      # Define a subnet range within the VPC CIDR
  availability_zone = "us-east-1a"       # Change this based on your AWS region
  tags = {
    Name = "sourav-subnet"
  }
}


resource "aws_internet_gateway" "igw" {
vpc_id = aws_vpc.sourav_vpc.id
tags = {
Name = "sourav-igw"
}
}

resource "aws_route_table" "my-route-table" {
vpc_id = aws_vpc.sourav_vpc.id
#Route anything with a CIDR of 0.0.0.0/0 to the IGW
route {
cidr_block = "0.0.0.0/0"
gateway_id = aws_internet_gateway.igw.id
}
tags = {
Name = "sourav-routetable"
}
}

resource "aws_route_table_association" "my-route-association" {
subnet_id = aws_subnet.sourav_subnet.id
route_table_id = aws_route_table.my-route-table.id
}
