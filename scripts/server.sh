#!/bin/bash

docker run -t -i -v --name open-elevation $(pwd)/data:/code/data -p 8001:8080 openelevation/open-elevation
