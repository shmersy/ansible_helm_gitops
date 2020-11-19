#!/bin/bash

MODE="$1"

if [ "${MODE,,}" = "uninstall" ]; then 
    ansible-playbook uninstall.yaml
else

    ansible-playbook install.yaml


fi