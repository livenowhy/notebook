all: push

TAG = 2.0
PREFIX = registry.cn-zhangjiakou.aliyuncs.com
IMAGE_NAME = livenowhy/influxdb
CONTAINER_NAME = influxdb


container:
	docker build -t ${PREFIX}/${IMAGE_NAME}:${TAG} .

push: container
	docker push ${PREFIX}/${IMAGE_NAME}:${TAG}

clean:
	docker rmi -f ${PREFIX}/${IMAGE_NAME}:${TAG} || true

run: rm
	docker run --name=${CONTAINER_NAME} -d -p 8086:8086 -p 2003:2003 -e INFLUXDB_GRAPHITE_ENABLED=true ${PREFIX}/${IMAGE_NAME}:${TAG}

stop:
	docker stop ${CONTAINER_NAME} || true

rm: stop
	docker rm -f ${CONTAINER_NAME} || true