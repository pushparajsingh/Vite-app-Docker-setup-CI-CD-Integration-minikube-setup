# Stage 1: Build (Isme code compile hoga)
# Node 18 ya 20 use karna safe hai, 24 abhi bahut naya hai
FROM node:20-alpine AS build-stage
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Stage 2: Serve (Sirf final build file Nginx mein jayegi)
FROM nginx:stable-alpine
# Vite use kar rahe ho toh 'dist' folder copy karna
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Apni custom nginx.conf copy kar rahe hain
COPY nginx.conf /etc/nginx/conf.d/default.conf 

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]