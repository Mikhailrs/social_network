run:
	docker run -d --rm -v ${PWD}:/app -v /var/run/postgresql:/var/run/postgresql -p 3000:3000 --name social_network social_network
stop:
	docker stop social_network