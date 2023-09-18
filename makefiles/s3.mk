
upload.bucket:
	@aws s3 cp ${CURDIR}/${APP_DIR}/build s3://${BUCKET_NAME} --recursive

url.bucket:
	@ echo http://${BUCKET_NAME}.s3-website-${AWS_REGION}.amazonaws.com

empty.bucket:
	@ aws s3 rm s3://${BUCKET_NAME} --recursive

