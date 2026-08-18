#!/usr/bin/env zsh

colima-start() {
  colima start vmx86_64 --cpu 4 --memory 4 --disk 130 --arch x86_64 --vm-type qemu
}
