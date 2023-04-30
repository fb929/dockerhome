# dockerhome
home in docker with encrypted home dir

## requires
[docker desktop](https://docs.docker.com/desktop)

## for init
```
# building and run docker container
make

# create encrypt data
sudo fallocate -l 10G /mnt/file
sudo cryptsetup -y luksFormat /mnt/file
sudo cryptsetup luksOpen /mnt/file data
sudo mkfs.ext4 -m 0 /dev/mapper/data
sudo mount /dev/mapper/data /home/
sudo su - <your user>
```
**$${\color{red}!!! file ./mnt/file is too big for github, so you should be backup it yourself in any way convenient for you !!!}$$**

## usage
```
# building and run docker container
make

# run already builded container
make run

# run with custom "search" for resolv.conf
make run DNS_SEARCH=mydomain.com

# building and run with custom user, by default user is taken from command "id -un"
make run USER=<myusername>

# attaching encrypt filesystem
/mnt/run.sh
```

## useful commands
```
docker system df
docker system prune -a
```
