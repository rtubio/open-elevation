# Open-Elevation

[https://open-elevation.com](https://open-elevation.com)

A free and open-source elevation API.

**Open-Elevation** is a free and open-source alternative to the [Google Elevation API](https://developers.google.com/maps/documentation/elevation/start) and similar offerings.

This service came out of the need to have a hosted, easy to use and easy to setup elevation API. While there are some alternatives out there, none of them work out of the box, and seem to point to dead datasets. <b>Open-Elevation</b> is [easy to setup](https://github.com/Jorl17/open-elevation/blob/master/docs/host-your-own.md), has its own docker image and provides scripts for you to easily acquire whatever datasets you want. We offer you the whole world with our [public API](https://github.com/Jorl17/open-elevation/blob/master/docs/api.md).

If you enjoy our service, please consider [donating to us](https://open-elevation.com#donate). Servers aren't free :)

**API Docs are [available here](https://github.com/Jorl17/open-elevation/blob/master/docs/api.md)**

You can learn more about the project, including its **free public API** in [the website](https://open-elevation.com)

# setup

* build docker image

    docker build -f config/Dockerfile .

* link the directory with the TIF images to "$(pwd)/data"

    ln -sf "$PATH_TO_TIF_DIR" data

* split out TIF images (raster to 10 10)

    bash scripts/create-dataset.sh data

* run docker image and detach it

  docker run --detach --name open-elevation -v $(pwd)/data:/code/data -p 8001:8080 openelevation/open-elevation
