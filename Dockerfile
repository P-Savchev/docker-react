# Build Phase
FROM node:lts-alpine as builder

WORKDIR '/app'

COPY package.json .
RUN npm install

COPY . .

RUN npm run build

# Run Phase
FROM nginx 

EXPOSE 80

COPY --from=builder /app/build /usr/share/nginx/html

# nginx will automatically run the server after copying the files