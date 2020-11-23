all: push

TAG = ali
PREFIX = registry.cn-zhangjiakou.aliyuncs.com
IMAGE_NAME = livenowhy/centos


container:
	docker build -t ${PREFIX}/${IMAGE_NAME}:${TAG} .

push: container
	docker push ${PREFIX}/${IMAGE_NAME}:${TAG}
#	docker tag ${PREFIX}/${IMAGE_NAME}:${TAG} registry.cn-beijing.aliyuncs.com/glodon-common/myops:${TAG}
#	docker push registry.cn-beijing.aliyuncs.com/glodon-common/myops:${TAG}

clean:
	docker rmi -f $(PREFIX):$(TAG) || true


# CentOS基础镜像制作

