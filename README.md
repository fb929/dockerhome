# dockerhome
home in docker

## for init
```
# build and run docker container
make
make run

# create encrypt data
sudo fallocate -l 10G /mnt/file
sudo cryptsetup -y luksFormat /mnt/file
sudo cryptsetup luksOpen /mnt/file data
sudo mkfs.ext4 -m 0 /dev/mapper/data
sudo mount /dev/mapper/data /home/
sudo su - g.efimov
```

## use
```
make run
/mnt/run.sh
```

## useful commands
```
docker system df
docker system prune -a
```
