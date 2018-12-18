#!/bin/bash

# Small script for the installation of the dependencies for open-elevation
# It basically creates the right virtual environment and adds to exports
# necessary to install GDAL

PACKAGES_FILE='debian.packages'
VENV_DIR='.env'
VENV_ACTIVATE="$VENV_DIR/bin/activate"
GDAL_INCLUDE_DIR='/usr/include/gdal'
DATA_DIR="$(pwd)/data"
DATASET_DIR="$HOME/local/documents/SRTM"
SRTM_NE_250m="$DATASET_DIR/SRTM_NE_250m_TIF.rar"
SRTM_SE_250m="$DATASET_DIR/SRTM_SE_250m_TIF.rar"
SRTM_W_250m="$DATASET_DIR/SRTM_W_250m_TIF.rar"

# 1) Install Debian packages
sudo apt update
sudo apt -y install $(grep -vE "^\s*#" $PACKAGES_FILE | tr "\n" " ")

# 2) Setup virtual environment
[[ ! -d "$VENV_ACTIVATE" ]] && {

  virtualenv --python=python3 "$VENV_DIR"
  source "$VENV_ACTIVATE"

  export CPLUS_INCLUDE_PATH="$GDAL_INCLUDE_DIR"
  export C_INCLUDE_PATH="$GDAL_INCLUDE_DIR"

  pip install -r requirements.txt

  deactivate

}

# 3) link static dataset
[[ ! -d "$DATA_DIR" ]] && {
  echo ">>> Creating $DATA_DIR"
  mkdir -p "$DATA_DIR"
}

ln -sf "$SRTM_NE_250m" "$DATA_DIR/"
ln -sf "$SRTM_SE_250m" "$DATA_DIR/"
ln -sf "$SRTM_W_250m" "$DATA_DIR/"
