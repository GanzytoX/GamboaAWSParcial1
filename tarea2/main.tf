# VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "tarea2-vpc-gg"
  }
}

# Public Subnet (DMZ)
resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${var.aws_region}a"
  tags = {
    Name = "tarea2-public-subnet-gg-a"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${var.aws_region}b"
  tags = {
    Name = "tarea2-public-subnet-gg-b"
  }
}

# Private Subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "${var.aws_region}a"
  tags = {
    Name = "tarea2-private-subnet-gg"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "tarea2-igw-gg"
  }
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "tarea2-public-rt-gg"
  }
}

# Public Route Table Association
resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}

# ECR Repository
resource "aws_ecr_repository" "app_repo" {
  name = "${var.app_name}-gg"
}

# Security Group for ALB
resource "aws_security_group" "alb_sg" {
  name        = "tarea2-alb-sg-gg"
  description = "Allow HTTP"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tarea2-alb-sg-gg"
  }
}

# Security Group for ECS Tasks
resource "aws_security_group" "ecs_sg" {
  name        = "tarea2-ecs-sg-gg"
  description = "Allow traffic from ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "App port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tarea2-ecs-sg-gg"
  }
}

# Application Load Balancer
resource "aws_lb" "alb" {
  name               = "tarea2-alb-gg"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_a.id, aws_subnet.public_b.id]
  tags = {
    Name = "tarea2-alb-gg"
  }
}

# Target Group
resource "aws_lb_target_group" "tg" {
  name     = "tarea2-tg-gg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  target_type = "ip"
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# Listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

# ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "tarea2-cluster-gg"
}

# ECS Task Definition
resource "aws_ecs_task_definition" "app" {
  family                   = "${var.app_name}-gg"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions    = jsonencode([
    {
      name      = "${var.app_name}-gg"
      image     = var.container_image
      portMappings = [{ containerPort = 80, hostPort = 80 }]
      essential  = true
    }
  ])
}

# IAM Role for ECS Task Execution
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole-gg"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "ecs-tasks.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# ECS Service
resource "aws_ecs_service" "app" {
  name            = "${var.app_name}-gg"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  launch_type     = "FARGATE"
  desired_count   = 1
  network_configuration {
    subnets         = [aws_subnet.public_a.id, aws_subnet.public_b.id]
    security_groups = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.tg.arn
    container_name   = "${var.app_name}-gg"
    container_port   = 80
  }
  depends_on = [aws_lb_listener.http]
}
