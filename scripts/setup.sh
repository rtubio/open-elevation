#!/bin/bash

# Small script for the installation of the dependencies for open-elevation
# It basically creates the right virtual environment and adds to exports
# necessary to install GDAL

####################
# IMPORTANT: This script is thought to be invoked from the ROOT of the project.
####################

ROOT='..'
CONFIG_DIR='config'
PACKAGES_FILE="$CONFIG_DIR/debian.packages"
REQUIREMENTS_FILE="$CONFIG_DIR/requirements.txt"
VENV_DIR='.env'
VENV_ACTIVATE="$VENV_DIR/bin/activate"
GDAL_INCLUDE_DIR='/usr/include/gdal'
DATA_DIR="$(pwd)/data"
DATASET_DIR="$HOME/local/documents/SRTM"
SRTM_NE_250m="$DATASET_DIR/SRTM_NE_250m.tif"
SRTM_SE_250m="$DATASET_DIR/SRTM_SE_250m.tif"
SRTM_W_250m="$DATASET_DIR/SRTM_W_250m.tif"

# 1) Install Debian packages

sudo apt update && sudo apt -y full-upgrade
echo ">>> PWD = $(pwd)"
sudo apt -y install $(grep -vE "^\s*#" "$PACKAGES_FILE" | tr "\n" " ")

# 2) Setup virtual environment

[[ ! -d "$VENV_DIR" ]] && {

  virtualenv --python=python3 "$VENV_DIR"
  source "$VENV_ACTIVATE"

  #export CPLUS_INCLUDE_PATH="$GDAL_INCLUDE_DIR"
  #export C_INCLUDE_PATH="$GDAL_INCLUDE_DIR"

  pip install -r "$REQUIREMENTS_FILE"

  pip uninstall GDAL

  pip install GDAL==2.1.3\
    --global-option=build_ext\
    --global-option="-I$GDAL_INCLUDE_DIR"

}

# 3) link static dataset

[[ ! -d "$DATA_DIR" ]] && {
  echo ">>> Creating $DATA_DIR"
  mkdir -p "$DATA_DIR"
}

ln -sf "$SRTM_NE_250m" "$DATA_DIR/"
ln -sf "$SRTM_SE_250m" "$DATA_DIR/"
ln -sf "$SRTM_W_250m" "$DATA_DIR/"
