all: push

TAG = 6.0.2
PREFIX = registry.cn-zhangjiakou.aliyuncs.com
IMAGE_NAME = livenowhy/grafana
CONTAINER_NAME = grafana

container:
	docker build -t ${PREFIX}/${IMAGE_NAME}:${TAG} .

push: container
	docker push ${PREFIX}/${IMAGE_NAME}:${TAG}

clean:
	docker rmi -f $(PREFIX):$(TAG) || true


run: rm pull
	docker run --name=${CONTAINER_NAME} -d -p 3000:3000 ${PREFIX}/${IMAGE_NAME}:${TAG

stop:
	docker stop ${CONTAINER_NAME} || true

rm: stop
	docker rm -f ${CONTAINER_NAME} || true



