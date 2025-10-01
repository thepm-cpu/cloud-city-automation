# 🏡 The Main Estate - VPC
resource "aws_vpc" "cloud_city" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name    = "cloud-city-vpc"
    Project = "cloud-city-automation"
  }
}

# 🚪 The Main Gate - Internet Gateway
resource "aws_internet_gateway" "main_gate" {
  vpc_id = aws_vpc.cloud_city.id

  tags = {
    Name = "cloud-city-igw"
  }
}

# 🛣️ Public Streets - Public Subnets
resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.cloud_city.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-street-${count.index + 1}"
  }
}

# 🛣️ Private Streets - Private Subnets
resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.cloud_city.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "private-street-${count.index + 1}"
  }
}

# 🗺️ Public Street Maps - Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.cloud_city.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_gate.id
  }

  tags = {
    Name = "public-street-map"
  }
}

# 📍 Street Signs - Route Table Associations
resource "aws_route_table_association" "public_subnet_asso" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rt.id
}
