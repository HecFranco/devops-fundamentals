# CREATE NETWORK

Creamos la red `lemoncode-challange`

```bash
$ docker network create lemoncode-challange
```

# FRONTEND

## Build Image 

```bash
$ docker build -t lemoncode-challange-frontend ./frontend/.
```

## Run Container

```bash
$ docker run -d --name lemoncode-frontend -p 3000:3000 lemoncode-challange-frontend 
```

# DATABASE

## Create Volume

```bash
$ docker volume create lemoncode-challange
```

## Build Image

```bash
$ docker build -t lemoncode-challange-database ./docker/mongodb/.
```

## Run Container

```bash
$ docker run -d --name lemoncode-database --network lemoncode-challange --restart unless-stopped --env-file .env --volume lemoncode-challange:/data/db lemoncode-challange-database 
```

# BACKEND

## Build Image

```bash
$ docker build -t lemoncode-challange-backend ./backend/.
```

## Run Container

```bash
$ docker run -d --name lemoncode-backend -p 5000:5000 --network lemoncode-challange lemoncode-challange-backend 
```
