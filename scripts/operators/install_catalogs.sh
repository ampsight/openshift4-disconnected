#!/bin/bash
  
# Script for installing the OperatorHub Catalog Source images in OpenShift 4

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
  
# Source the environment file with the default settings
source "${SCRIPT_DIR}/../env.sh"

if [ "${RH_OP}" = true ]
then

  # Apply the ImageContentSourcePolicy
  oc apply -f redhat-operators-manifests/imageContentSourcePolicy.yaml

  # Update the private registry name and apply the catalog source
  sed "s/REGISTRY/${REMOTE_REG}/" redhat-operators-catalogsource.yaml | oc apply -f -

fi

if [ "${CERT_OP}" = true ]
then

  # Apply the ImageContentSourcePolicy
  oc apply -f certified-operators-manifests/imageContentSourcePolicy.yaml

  # Update the private registry name and apply the catalog source
  sed "s/REGISTRY/${REMOTE_REG}/" certified-operators-catalogsource.yaml | oc apply -f -

fi

if [ "${COMM_OP}" = true ]
then

  # Apply the ImageContentSourcePolicy
  oc apply -f community-operators-manifests/imageContentSourcePolicy.yaml

  # Update the private registry name and apply the catalog source
  sed "s/REGISTRY/${REMOTE_REG}/" community-operators-catalogsource.yaml | oc apply -f -

fi

exit 0
