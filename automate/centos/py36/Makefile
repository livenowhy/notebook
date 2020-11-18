all: push

TAG = py36
PREFIX = registry.cn-zhangjiakou.aliyuncs.com
IMAGE_NAME = livenowhy/centos

container:
	wget https://bootstrap.pypa.io/get-pip.py
	docker build -t ${PREFIX}/${IMAGE_NAME}:${TAG} .
	rm get-pip*.py

push: container
	docker push ${PREFIX}/${IMAGE_NAME}:${TAG}

clean:
	docker rmi -f $(PREFIX):$(TAG) || true
