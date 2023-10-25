FROM golang:1.17 as builder

WORKDIR /app
COPY . .

RUN go mod init myapp
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /app
COPY --from=builder /app/main /app/

EXPOSE 8080
ENTRYPOINT ["/app/main"]