from busybox:1.37

# Create a non-root user
RUN adduser -D -u 1000 myuser

# Switch to the non-root user
USER myuser

# Set default command
CMD ["echo", "Hello form BusyBox!"]
