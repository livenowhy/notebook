# docker 镜像仓库

## Registry v2 token 机制
    
    官方document: https://docs.docker.com/registry/spec/auth/token/
  
## 认证步骤:
  
  ![认证流程图](../../images/docker/docker_registry_authentication.png)
  
  `1` Docker Client 尝试到registry中进行push/pull操作
    
    Attempt to begin a push/pull operation with the registry.
  
  `2` 如果registry需要认证,它会返回一个401未认证信息,并且返回的信息中还包含了到哪里去认证的信息。
    
    If the registry requires authorization it will return a 401 Unauthorized HTTP response with information on how to authenticate.
  
  `3` client发送认证请求到认证服务器(authorization service)
    
    The registry client makes a request to the authorization service for a Bearer token.
  
  `4` 认证服务器(authorization service)返回token
    
    The authorization service returns an opaque Bearer token representing the client’s authorized access.
  
  `5` client携带这附有token的请求，尝试请求registry
    
    The client retries the original request with the Bearer token embedded in the request’s Authorization header.
  
  `6` registry 接受了认证的token并且使得client继续操作
  
    The Registry authorizes the client by validating the Bearer token and the claim set embedded within it and begins the push/pull session as usual.
    
    参考文章: http://www.tuicool.com/articles/UrMFBn

## mirror for private registry 配置 (私有镜像库配置 mirror 功能)

### 修改 registry 配置

	version: 0.1
	log:
	  fields:
	    service: registry
	storage:
	  cache:
	    blobdescriptor: inmemory
	  filesystem:
	    rootdirectory: /var/lib/registry
	http:
	  addr: :5000
	  headers:
	    X-Content-Type-Options: [nosniff]
	health:
	  storagedriver:
	    enabled: true
	    interval: 10s
	    threshold: 3

	# 以上为原始配置; 如果想使用 mirror 功能只需在下面增加 proxy 选项即可
	proxy:
	  remoteurl: https://registry-1.docker.io
      # username: [username]
	  # password: [password]

	# username 与 password 是可选项，当填写 username 与 password 以后就可以从 hub pull 私有镜像

### 启动 mirror registry

    docker run -dt -v /data/registry:/var/lib/registry -v /root/mirr/config.yml:/etc/docker/registry/config.yml -p 5000:5000 registry:2.5.0

    到此就已经成功启动一个私有的镜像库并且带有 mirror 功能