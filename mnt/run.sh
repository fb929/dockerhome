#!/bin/bash

sudo cryptsetup luksClose data
sudo cryptsetup luksOpen /mnt/file data
sudo mount /dev/mapper/data /home/
sudo su - g.efimov
