resource "aws_vpc" "team2" {
  cidr_block = "10.2.0.0/22"
  tags = {
    Name = "${var.identity}team2"
  }
}

# Create an Internet Gateway to allow communication between the VPC and the internet
resource "aws_internet_gateway" "team2_igw" {
  vpc_id = aws_vpc.team2.id
  tags = {
    Name = "${var.identity}team2-igw"
  }
}

# Create a Public Subnet #1
resource "aws_subnet" "team2_subnet_2a" {
  vpc_id                  = aws_vpc.team2.id
  cidr_block              = "10.2.0.0/24"
  availability_zone       = "ap-northeast-2a"
#  map_public_ip_on_launch = true # Public IP 자동 할당
  tags = {
    Name = "${var.identity}team2-subnet-2a"
  }
}

# Create a Public Subnet #2
resource "aws_subnet" "team2_subnet_2b" {
  vpc_id                  = aws_vpc.team2.id
  cidr_block              = "10.2.1.0/24"
  availability_zone       = "ap-northeast-2b"
# map_public_ip_on_launch = true # Public IP 자동 할당
  tags = {
    Name = "${var.identity}team2-subnet-2b"
  }
}

# Create a Public Subnet #3
resource "aws_subnet" "team2_subnet_2c" {
  vpc_id                  = aws_vpc.team2.id
  cidr_block              = "10.2.2.0/24"
  availability_zone       = "ap-northeast-2c"
# map_public_ip_on_launch = true # Public IP 자동 할당
  tags = {
    Name = "${var.identity}team2-subnet-2c"
  }
}

# Create a Public Subnet #4
resource "aws_subnet" "team2_subnet_2d" {
  vpc_id                  = aws_vpc.team2.id
  cidr_block              = "10.2.3.0/24"
  availability_zone       = "ap-northeast-2d"
# map_public_ip_on_launch = true # Public IP 자동 할당
  tags = {
    Name = "${var.identity}team2-subnet-2d"
  }
}

# Create a Route Table for public subnets
resource "aws_route_table" "team2_public_rt" {
  vpc_id = aws_vpc.team2.id
  tags = {
    Name = "${var.identity}team2-public-rt"
  }
}

# Add a route to the Internet Gateway
resource "aws_route" "public_internet_route" {
  route_table_id         = aws_route_table.team2_public_rt.id
  destination_cidr_block = "0.0.0.0/0" # 모든 트래픽
  gateway_id             = aws_internet_gateway.team2_igw.id
}

# Associate public subnet #1 with the public route table
resource "aws_route_table_association" "team2_subnet_2a_association" {
  subnet_id      = aws_subnet.team2_subnet_2a.id
  route_table_id = aws_route_table.team2_public_rt.id
}

# Associate public subnet #2 with the public route table
resource "aws_route_table_association" "team2_subnet_2b_association" {
  subnet_id      = aws_subnet.team2_subnet_2b.id
  route_table_id = aws_route_table.team2_public_rt.id
}

# Associate public subnet #3 with the public route table
resource "aws_route_table_association" "team2_subnet_2c_association" {
  subnet_id      = aws_subnet.team2_subnet_2c.id
  route_table_id = aws_route_table.team2_public_rt.id
}

# Associate public subnet #4 with the public route table
resource "aws_route_table_association" "team2_subnet_2d_association" {
  subnet_id      = aws_subnet.team2_subnet_2d.id
  route_table_id = aws_route_table.team2_public_rt.id
}

# Create a Security Group
resource "aws_security_group" "team2sg" {
  name        = "${var.identity}team2sg"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.team2.id

  # Ingress rules: Allow all traffic from anywhere
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # All protocols
    cidr_blocks = ["0.0.0.0/0"] # Anywhere IPv4
  }

  # Egress rules: Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # All protocols
    cidr_blocks = ["0.0.0.0/0"] # Anywhere IPv4
  }

  tags = {
    Name = "${var.identity}team2sg"
  }
}