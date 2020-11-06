# 守护进程管理 node_exporter

    $ vim /usr/lib/systemd/system/node_exporter.service
    [Unit]
    Description=node_exporter
    Documentation=https://prometheus.io/docs/introduction/overview
    After=network-online.target remote-fs.target nss-lookup.target
    Wants=network-online.target
    
    [Service]
    Type=simple
    PIDFile==/var/run/node_exporter.pid
    ExecStart=/usr/bin/node_exporter
    ExecReload=/bin/kill -s HUP $MAINPID
    ExecStop=/bin/kill -s TERM $MAINPID
    
    [Install]
    WantedBy=multi-user.target
    
    
    $ systemctl daemon-reload
    $ systemctl start node_exporter
    $ ps -ef | grep node_exporter
    $ netstat -tulnp | grep 9100
    tcp6       0      0 :::9100                 :::*                    LISTEN      51060/node_exporter
    $ systemctl restart node_exporter