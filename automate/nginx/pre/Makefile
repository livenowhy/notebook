all: push

TAG = pre
PREFIX = registry.cn-zhangjiakou.aliyuncs.com
IMAGE_NAME = livenowhy/nginx
CONTAINER_NAME = 'nginx'

container:
	docker build -t ${PREFIX}/${IMAGE_NAME}:${TAG} .

push: container
	docker push ${PREFIX}/${IMAGE_NAME}:${TAG}

clean:
	docker rmi -f $(PREFIX):$(TAG) || true

start:
	docker run --name=${CONTAINER_NAME} -d -p 80:80 ${PREFIX}/${IMAGE_NAME}:${TAG}

stop:
	docker stop ${CONTAINER_NAME} || true

rm: stop
	docker rm -f ${CONTAINER_NAME} || true

restart: stop rm start