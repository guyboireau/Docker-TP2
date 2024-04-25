# Stage 1: Build
FROM node:20 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Production
FROM node:20 AS production
WORKDIR /app
COPY package*.json ./
RUN npm install --only=production
COPY --from=build . ./dist
EXPOSE 1337
CMD ["npm", "run", "start"]
