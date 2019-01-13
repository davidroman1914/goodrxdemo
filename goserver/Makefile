
.PHONY: build deploy destroy all infra-up infra-down help

################
# Local Dev-ing. 
################

build: ## Build The Go Server App.
	@echo "Building App" && \
	cd app && docker-compose -f build.yaml build

deploy: build ## Deploying The Go Server App.
	@echo "Deploying App" && \
	cd app && docker-compose -f build.yaml up -d

destroy: ## Destorying The Go Server App.
	@echo "Destroying App" && \
	cd app && docker-compose -f build.yaml down

################
# AWS INFRA 
################
infra-init:
	@echo "Terraform Init..." && \
	cd infra && terraform init

infra-up: infra-init ## Create AWS Infrastructure.
	@echo "Create AWS Infrastructure..." && \
	cd infra && terraform apply

infra-down: ## Destroy AWS Infrastructure.
	@echo "Destroying AWS Infrastructure..." && \
	cd infra && terraform destroy

get-pub-ip: ## Return The Public IP.
	cd infra && terraform output public_ip

get-elb-dns: ## Return The ELB DNS.
	cd infra && terraform output dns_name
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
