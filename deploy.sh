#!/bin/bash

set -o errexit -o nounset

cd aws_account

terraform init -input=false

terraform validate

terraform plan

terraform apply -input=false -auto-approve