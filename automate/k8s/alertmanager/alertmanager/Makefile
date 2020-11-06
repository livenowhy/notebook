all: push

TAG = v0.15.3
PREFIX = registry.cn-zhangjiakou.aliyuncs.com
IMAGE_NAME = livenowhy/alertmanager
CONTAINER_NAME = alertmanager

container:
	docker build -t ${PREFIX}/${IMAGE_NAME}:${TAG} .

push: container
	docker push ${PREFIX}/${IMAGE_NAME}:${TAG}

clean:
	docker rmi -f $(PREFIX):$(TAG) || true

