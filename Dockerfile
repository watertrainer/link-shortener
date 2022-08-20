FROM node AS builder
WORKDIR /build
COPY . .
WORKDIR /build/link-shortener-frontend
RUN npm ci && npm i -g @angular/cli
RUN ng build --configuration production --base-href /home/ --output-path ./../link-shortener-backend/dist
WORKDIR /build/link-shortener-backend
RUN npm install --omit=dev


FROM node AS End_stage
WORKDIR /server
COPY --from=builder /build/link-shortener-backend .
RUN npm ci --omit=dev
CMD ["node","server.js"]