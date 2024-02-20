#!/usr/bin/env bash

helm upgrade --install --create-namespace -n metallb metallb metallb/metallb
