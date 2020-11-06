all: push

TAG = lastest
PREFIX = registry.cn-zhangjiakou.aliyuncs.com
IMAGE_NAME = livenowhy/pushgateway
CONTAINER_NAME = pushgateway


container:
	docker build -t ${PREFIX}/${IMAGE_NAME}:${TAG} .

push: container
	docker push ${PREFIX}/${IMAGE_NAME}:${TAG}

clean:
	docker rmi -f ${PREFIX}/${IMAGE_NAME}:${TAG} || true


run: rm push
	docker run --name=${CONTAINER_NAME} -d -p 9091:9091 ${PREFIX}/${IMAGE_NAME}:${TAG}

stop:
	docker stop ${CONTAINER_NAME} || true

rm: stop
	docker rm -f ${CONTAINER_NAME} || true



