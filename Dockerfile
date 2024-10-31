# Use Ubuntu as a base image
FROM ubuntu:latest

# Install any necessary packages
RUN apt update && apt install -y procps

# Copy your script into the image
COPY server-stats.sh /usr/local/bin/server-stats.sh

# Make the script executable
RUN chmod +x /usr/local/bin/server-stats.sh

# Run the script by default when the container starts
CMD ["/usr/local/bin/server-stats.sh"]
