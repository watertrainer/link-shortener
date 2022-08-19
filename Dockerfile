FROM node AS builder
WORKDIR /build
COPY . .
WORKDIR /build/link-shortener-frontend
RUN npm install --omit=dev && npm i -g @angular/cli
RUN ng build --configuration development --base-href /home/ --output-path ./../link-shortener-backend/dist
WORKDIR /build/link-shortener-backend
RUN npm install --omit=dev

# [Choice] Node.js version (use -bullseye variants on local arm64/Apple Silicon): 18, 16, 14, 18-bullseye, 16-bullseye, 14-bullseye, 18-buster, 16-buster, 14-buster
ARG VARIANT=16-bullseye
FROM mcr.microsoft.com/vscode/devcontainers/javascript-node:0-${VARIANT} AS End_stage
WORKDIR /server
COPY --from=builder /build/link-shortener-backend .
CMD ["node","server.js"]

ARG VARIANT=16-bullseye
FROM mcr.microsoft.com/vscode/devcontainers/javascript-node:0-${VARIANT} AS dev