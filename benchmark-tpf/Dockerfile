# Use the official Node.js 20 image
FROM node:20.18.1

# Set the working directory inside the container
WORKDIR /app

# Confirm npm version to check if it is installed
RUN npm --version

# Install necessary global packages
RUN npm install -g hdt 
RUN npm install -g @ldf/server 
RUN npm install -g @ldf/datasource-hdt 
RUN apt-get update && apt-get install -y bash time

# Expose the port for the LDF server
EXPOSE 5000

# Default entrypoint for the Docker container
ENTRYPOINT ["sh", "-c"]
