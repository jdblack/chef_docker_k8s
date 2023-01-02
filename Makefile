

docker:
	docker build . -t cinc

deploy: docker
	docker tag cinc registry:5000/cinc 
	docker push registry:5000/cinc 

run: docker
	docker run -ti -d -p 443:443 cinc /bin/bash

