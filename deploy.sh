#!/bin/bash

set -o errexit -o nounset

cd aws_account

/usr/bin/terraform --version

/usr/bin/terraform init -input=false

/usr/bin/terraform validate

/usr/bin/terraform plan

/usr/bin/terraform apply -input=false -auto-approve
