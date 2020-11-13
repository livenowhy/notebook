all: push

TAG = 1.15.5-alpine3.12
PREFIX = registry.cn-zhangjiakou.aliyuncs.com
IMAGE_NAME = livenowhy/golang
CONTAINER_NAME = golang


container:
	docker build -t ${PREFIX}/${IMAGE_NAME}:${TAG} .

push: container
	docker push ${PREFIX}/${IMAGE_NAME}:${TAG}

clean:
	docker rmi -f ${PREFIX}/${IMAGE_NAME}:${TAG} || true


run: rm
	docker run --name=${CONTAINER_NAME} -d  ${PREFIX}/${IMAGE_NAME}:${TAG}

stop:
	docker stop ${CONTAINER_NAME} || true

rm: stop
	docker rm -f ${CONTAINER_NAME} || true