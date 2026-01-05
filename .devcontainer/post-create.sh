#!/bin/bash
set -e

cd /workspaces/playground

date
make try-eda NO_KIND=yes NO_LB=yes
date

make configure-codespaces-keycloak