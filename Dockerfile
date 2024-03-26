# build stage 
FROM golang:alpine AS builder 

# Set the working directory 
WORKDIR /app

# Copy and download dependencies 
COPY go.mod go.sum ./
RUN go mod download 

# Copy the source code 
COPY . .

#BUILD THE Go application
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o hello hello.go

# the run stage
FROM scratch

# Set the working directory 
WORKDIR /app

# Copy the binary from the build stage
COPY --from=builder /app/hello .

EXPOSE 8080

CMD ["chmod", "+x", "hello"] 
ENTRYPOINT ["./hello"]