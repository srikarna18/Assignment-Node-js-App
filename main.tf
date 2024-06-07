provider "aws" {
  region = "us-west-1"
}

# Create an ECS cluster
resource "aws_ecs_cluster" "example" {
  name = "example-cluster"
}

# Create an ECS task definition
resource "aws_ecs_task_definition" "example" {
  family                = "example-task-definition"
  requires_compatibilities = ["FARGATE"]
  network_mode          = "awsvpc"
  cpu                    = 256
  memory               = 512
  execution_role_arn = "arn:aws:iam::123456789012:role/ecsTaskExecutionRole"

  container_definitions = jsonencode([
    {
      name      = "example-container"
      image      = "your-docker-image-repository-url/my-nodejs-app:latest"
      cpu        = 256
      memory     = 512
      essential = true
      portMappings = [
        {
          containerPort = 5000
          hostPort      = 5000
        }
      ]
    }
  ])
}

# Create an ECS service
resource "aws_ecs_service" "example" {
  name            = "example-service"
  cluster         = aws_ecs_cluster.example.name
  task_definition = aws_ecs_task_definition.example.arn
  desired_count   = 1
  launch_type      = "FARGATE"
  network_configuration {
    awsvpc_configuration {
      subnets          = ["subnet-12345678"]
      security_groups = ["sg-12345678"]
      assign_public_ip = "ENABLED"
    }
  }
}
