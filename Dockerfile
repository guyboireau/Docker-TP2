# Development
FROM node:20 AS development
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "run", "develop"]

# Build
FROM node:20 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Production
FROM node:20 AS production
WORKDIR /app
COPY package*.json ./
RUN npm install --only=production
COPY --from=build ./app ./dist
EXPOSE 1337
CMD ["npm", "run", "start"]
