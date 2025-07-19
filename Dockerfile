# Use a lighter base image (Debian + Node.js + pre-installed Chromium)
FROM node:18-bullseye-slim

# Install Chromium dependencies (required for Puppeteer)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    chromium \
    fonts-ipafont-gothic \
    fonts-wqy-zenhei \
    fonts-thai-tlwg \
    fonts-khmeros \
    fonts-freefont-ttf \
    && rm -rf /var/lib/apt/lists/*

# Set Puppeteer config (skip download, use system Chromium)
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

WORKDIR /usr/src/app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install --production

# Copy app files
COPY . .

# Run the app
CMD ["node", "index.js"]
