#!/bin/bash

docker build -f config/Dockerfile -t open-elevation .

docker run -t -i -d --name open-elevation -v $(pwd)/data:/code/data -p 8001:8080 open-elevation
