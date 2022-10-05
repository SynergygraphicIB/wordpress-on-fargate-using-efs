[
  {
    "name": "${task_definition_name}",
    "image": "${app_image}",
    "essential": true,
    "cpu": ${fargate_cpu
    },
    "memory": ${fargate_memory
    },
    "networkMode": "awsvpc",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${log_group_path}",
        "awslogs-region": "${region}",
        "awslogs-stream-prefix": "ecs-stream"
      }
    },
    "portMappings": [
      {
        "containerPort": ${app_port
        },
        "hostPort": ${app_port
        }
      }
    ]
  }
]