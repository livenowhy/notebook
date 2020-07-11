all: push

TAG = notebook
PREFIX = registry.cn-zhangjiakou.aliyuncs.com
IMAGE_NAME = livenowhy/node

CONTAINER_V = /share/notebook:/share/notebook
CONTAINER_NAME = notebook

container:
	docker build -t ${PREFIX}/${IMAGE_NAME}:${TAG} .

push: container
	docker push ${PREFIX}/${IMAGE_NAME}:${TAG}

clean:
	docker rmi -f $(PREFIX):$(TAG) || true

pull:
	docker pull ${PREFIX}/${IMAGE_NAME}:${TAG}

run:
	docker run --name=${CONTAINER_NAME} -d -p 4000:4000 -p 35729:35729 registry.cn-zhangjiakou.aliyuncs.com/livenowhy/node:notebook

# 测试使用 node:gitbook 镜像, 使用挂载 文件方式
dev:
	docker run --name=${CONTAINER_NAME} -itd -p 9999:4000 -p 35729:35729 -v ${CONTAINER_V} registry.cn-zhangjiakou.aliyuncs.com/livenowhy/node:gitbook

stop:
	docker stop ${CONTAINER_NAME} || true

rm: stop
	docker rm -f ${CONTAINER_NAME} || true

# docker rm `docker ps -aq`
