FROM golang:latest as builder
ARG ENV
WORKDIR /app
COPY . .
RUN go mod download \
 && CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

FROM scratch
COPY --from=builder /app/main .
EXPOSE 8080
USER 9999
CMD ["./main"]
