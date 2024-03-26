### Start the Server 

```sh
APIURL=http://localhost:8080/api ./run-api-tests.sh

go run hello.go 
```


### Containerize the Application 
MultiStage builds is a recommended way to build production containers

`docker build -t go-backend .`
