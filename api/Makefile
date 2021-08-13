.PHONY: up
up:
	@echo "============= Spinning Everything Up ============="
	docker-compose up -d

.PHONY: down
down:
	@echo "============= Taking Everything Down ============="
	docker-compose down

.PHONY: logs
logs:
	@echo "============= View Logs ============="
	docker-compose logs -f

.PHONY: images
images:
	@echo "============= Rebuilding Docker Images ============="
	docker-compose build

.PHONY: get
get:
	@echo "============= Go Get It ============="
	docker exec -it biblegoapi_go-api_1 go get ./

.PHONY: api
api:
	@echo "============= Building API ============="
	docker exec -it biblegoapi_go-api_1 go build -o /go/bin/server
	docker container kill biblegoapi_go-api_1
	docker container start biblegoapi_go-api_1

.PHONY: test
test:
	@echo "============= Running Tests ============="
	docker exec -it biblegoapi_go-api_1 go test

