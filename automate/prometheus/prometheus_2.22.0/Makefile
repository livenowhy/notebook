all: push

TAG = 2.22.0
PREFIX = registry.cn-zhangjiakou.aliyuncs.com
IMAGE_NAME = livenowhy/prometheus
CONTAINER_NAME = prometheus

fetch_prometheus:
	wget https://github.com/prometheus/prometheus/releases/download/v${TAG}/prometheus-${TAG}.linux-amd64.tar.gz
	tar -zxvf prometheus-${TAG}.linux-amd64.tar.gz

clean_prometheus:
	rm -r prometheus-${TAG}.linux-amd64.tar.gz
	rm -r prometheus-${TAG}.linux-amd64

container: fetch_prometheus
	docker build -t ${PREFIX}/${IMAGE_NAME}:${TAG} .

push: container
	docker push ${PREFIX}/${IMAGE_NAME}:${TAG}

clean:
	docker rmi -f ${PREFIX}/${IMAGE_NAME}:${TAG || true


run: rm pull
	docker run --name=${CONTAINER_NAME} -d -p 9090:9090 ${PREFIX}/${IMAGE_NAME}:${TAG}

stop:
	docker stop ${CONTAINER_NAME} || true

rm: stop
	docker rm -f ${CONTAINER_NAME} || true



