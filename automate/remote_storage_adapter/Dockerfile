FROM registry.cn-zhangjiakou.aliyuncs.com/livenowhy/golang:1.15.5-alpine3.12
MAINTAINER livenowhy <livenowhy@hotmail.com>

RUN go get -d -v github.com/prometheus/prometheus/documentation/examples/remote_storage/remote_storage_adapter
RUN go build -v github.com/prometheus/prometheus/documentation/examples/remote_storage/remote_storage_adapter

#FROM scratch
#COPY --from=builder /go/remote_storage_adapter /bin/remote_storage_adapter
#ENTRYPOINT ["/bin/remote_storage_adapter"]
