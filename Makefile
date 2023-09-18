.DEFAULT_GOAL := help

include makefiles/s3.mk
include makefiles/terraform.mk

OWNER          	= migration
TYPE_APP        = web
SERVICE_NAME    = app
ENV             ?= dev
AWS_REGION 		= us-west-2

PROJECT_NAME    = ${OWNER}-${TYPE_APP}-${SERVICE_NAME}-${ENV}
IMAGE           = $(PROJECT_NAME):latest
BUCKET_NAME 	= ${OWNER}.${TYPE_APP}.${SERVICE_NAME}.${ENV}.bucket

REPOSITORY_APP	?= https://github.com/victorcastillo97/inventory.webapp.front.git
CLONE_DIR		= app

APP_DIR			= ${CLONE_DIR}/app
WORKDIR        	= app


clone.app:
	@ git clone ${REPOSITORY_APP} ${CLONE_DIR}

build.image: ## Construir imagen en dev: make build.image
	@docker build \
		-f ./docker/dev/Dockerfile \
		-t ${IMAGE} \
		. \
		--no-cache
		
deps.install:
	@ docker run -i \
	--rm \
	-v ${CURDIR}/${APP_DIR}:/${WORKDIR} \
	${IMAGE} \
	yarn install

build.app:
	@docker run \
		-i \
		--rm \
		-v ${CURDIR}/${APP_DIR}:/${WORKDIR} \
		${IMAGE} \
		yarn build

shell: ## Ejecutar shell: make shell
	@docker run \
		--rm \
		-it \
		-v ${CURDIR}/${APP_DIR}:/${WORKDIR} \
		-p 3000:3000 \
		${IMAGE} sh
