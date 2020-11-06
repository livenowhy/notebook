all: push

TAG = 6.0
PREFIX = registry.cn-zhangjiakou.aliyuncs.com
IMAGE_NAME = livenowhy/redis

container:
	docker build -t ${PREFIX}/${IMAGE_NAME}:${TAG} .

push: container
	docker push ${PREFIX}/${IMAGE_NAME}:${TAG}

clean:
	docker rmi -f $(PREFIX):$(TAG) || true
