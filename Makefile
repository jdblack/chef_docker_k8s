

docker:
	docker build . -t cinc

deploy: docker
	docker tag cinc registry:5000/cinc 
	docker push registry:5000/cinc 
	docker tag cinc jdblack/cinc_k8s
	docker push jdblack/cinc_k8s

run: docker
	docker run -ti -d -p 443:443 cinc /bin/bash

