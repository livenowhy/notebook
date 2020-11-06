all: push

TAG = base_alpine
PREFIX = registry.cn-zhangjiakou.aliyuncs.com
IMAGE_NAME = livenowhy/node

container:
	docker build -t ${PREFIX}/${IMAGE_NAME}:${TAG} .

push: container
	docker push ${PREFIX}/${IMAGE_NAME}:${TAG}

clean:
	docker rmi -f $(PREFIX):$(TAG) || true


# registry.cn-hangzhou.aliyuncs.com/livenowhy/node:base_alpine
