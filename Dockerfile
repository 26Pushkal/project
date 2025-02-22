# Use the official Node.js image
FROM node:14

RUN groupadd -r admin2 && useradd -r -g admin2 admin2

USER admin2

# Set the working directory in the container
WORKDIR /app

# Copy the application files to the container
COPY . .

# Install dependencies
RUN npm install

# Expose the port the app will run on
#EXPOSE 3000

# Command to run the app
CMD ["npm", "start"]
