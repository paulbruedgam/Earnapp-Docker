# Earnapp for Docker
Multi-Arch Docker-Image for https://earnapp.com/. The image will be build twice a day.

You can donate by using my invite link https://earnapp.com/i/z23pjdm.

## Usage
### Using Docker
```bash
# create data dir
mkdir earnapp-data
# start container
docker run -d \
  -v $PWD/earnapp-data:/etc/earnapp \
  --name earnapp \
  ghcr.io/paulbruedgam/earnapp-docker/earnapp:latest
```

### Using docker-compose
Clone Repository
```bash
git clone https://github.com/paulbruedgam/earnapp-docker.git
# change to directory
cd earnapp-docker
# start container
docker-compose up -d
```

## Like my work?
Consider donating.
- Earnapp: https://earnapp.com/i/z23pjdm
- PayPal: [@pbruedgam](https://www.paypal.me/pbruedgam)
