
TERRAFORM_DIR 		= terraform

infra.plan:
	@ terraform -chdir=${CURDIR}/${TERRAFORM_DIR} \
				plan -var="bucket_name=${BUCKET_NAME}"

infra.apply:
	@ terraform -chdir=${CURDIR}/${TERRAFORM_DIR} \
				apply -var="bucket_name=${BUCKET_NAME}" \
				--auto-approve

infra.destroy:
	@ terraform -chdir=${CURDIR}/${TERRAFORM_DIR} \
				destroy -var="bucket_name=${BUCKET_NAME}" \
				--auto-approve
	