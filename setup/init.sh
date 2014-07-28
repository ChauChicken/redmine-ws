#!/bin/bash

BASE_DIR=$(dirname $0)
DIR_WS=/ws

./$BASE_DIR/config.sh

cd $DIR_WS
ruby projects.rb
