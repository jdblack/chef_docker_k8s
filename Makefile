

docker:
	docker build . -t chef

deploy: docker
	docker tag chef registry:5000/chef 
	docker push registry:5000/chef 

run: docker
	docker run --privileged -ti -d -p 443:443 chef /bin/bash

