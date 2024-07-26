FROM alpine:latest
ADD arch-test.sh /app/
WORKDIR /app
CMD ["/bin/ash", "/app/arch-test.sh"]
