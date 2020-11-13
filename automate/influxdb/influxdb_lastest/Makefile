all: push

TAG = lastest
PREFIX = registry.cn-zhangjiakou.aliyuncs.com
IMAGE_NAME = livenowhy/influxdb
CONTAINER_NAME = influxdb


container:
	docker build -t ${PREFIX}/${IMAGE_NAME}:${TAG} .

push: container
	docker push ${PREFIX}/${IMAGE_NAME}:${TAG}

clean:
	docker rmi -f ${PREFIX}/${IMAGE_NAME}:${TAG} || true