# Use official Node.js image (choose version you need)
FROM node:20-alpine

# Set working directory inside container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json first (for caching)
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy application source code
COPY . .

# Expose port (adjust if your app uses a different one)
EXPOSE 3000

# Run index.js with Node
CMD ["node", "index.js"]
