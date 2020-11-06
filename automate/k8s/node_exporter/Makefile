all: push

TAG = latest
PREFIX = registry.cn-zhangjiakou.aliyuncs.com
IMAGE_NAME = livenowhy/node_exporter
CONTAINER_NAME = node_exporter

container:
	docker build -t ${PREFIX}/${IMAGE_NAME}:${TAG} .

push: container
	docker push ${PREFIX}/${IMAGE_NAME}:${TAG}

clean:
	docker rmi -f $(PREFIX):$(TAG) || true


run: rm pull
	docker run --name=${CONTAINER_NAME} -d -p 9090:9090 ${PREFIX}/${IMAGE_NAME}:${TAG

stop:
	docker stop ${CONTAINER_NAME} || true

rm: stop
	docker rm -f ${CONTAINER_NAME} || true



