#!/bin/bash

echo "Waiting dind to launch on 2375..."

while ! nc -z localhost 2375; do   
  sleep 0.1 # wait for 1/10 of the second before check again
done

echo "Dind launched"
