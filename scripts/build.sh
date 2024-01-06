#!/bin/bash

set -x

pushd ../zmk

if [ -f .venv/bin/activate ]; then
    source .venv/bin/activate
elif [ -f .venv/Scripts/activate ]; then
    source .venv/Scripts/activate
else
    echo "Setup a Python virtual environment for ZMK please"
    exit 1
fi

cd app
west build -d build/left
west build -d build/right
find . -name "*.uf2"
LEFT=$(pwd)/build/left/zephyr/zmk.uf2
RIGHT=$(pwd)/build/right/zephyr/zmk.uf2
popd
mkdir -p firmware/current
cp $LEFT firmware/current/left.uf2
cp $RIGHT firmware/current/right.uf2
