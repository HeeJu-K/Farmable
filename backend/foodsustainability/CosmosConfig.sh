#!/bin/bash
# Author  : Mark A. Heckler
# Notes   : Run with 'source CosmosConfig.sh' from your shell/commandline environment AFTER CosmosInitEnv.sh
# History : Official "version 1" 20220818.

# REQUIREMENTS
## Azure CLI (az)

# Resource group config
echo '>> az group create -l $AZ_LOCATION -g $AZ_RESOURCE_GROUP --subscription $AZ_SUBSCRIPTION'
# az group create -l $AZ_LOCATION -g $AZ_RESOURCE_GROUP --subscription $AZ_SUBSCRIPTION

# Cosmos/SQL option
# echo '>> az cosmosdb create -n $COSMOSDB_SQL_ACCOUNT -g $AZ_RESOURCE_GROUP'
# az cosmosdb create -n $COSMOSDB_SQL_ACCOUNT -g $AZ_RESOURCE_GROUP
# echo '>> az cosmosdb sql database create -a $COSMOSDB_SQL_ACCOUNT -n $COSMOSDB_SQL_NAME -g $AZ_RESOURCE_GROUP'
# az cosmosdb sql database create -a $COSMOSDB_SQL_ACCOUNT -n $COSMOSDB_SQL_NAME -g $AZ_RESOURCE_GROUP
# echo '>> az cosmosdb sql container create -a $COSMOSDB_SQL_ACCOUNT -d $COSMOSDB_SQL_NAME -n $COSMOSDB_CONTAINER -p $COSMOSDB_DATA_PART -g $AZ_RESOURCE_GROUP'
# az cosmosdb sql container create -a $COSMOSDB_SQL_ACCOUNT -d $COSMOSDB_SQL_NAME -n $COSMOSDB_CONTAINER -p $COSMOSDB_DATA_PART -g $AZ_RESOURCE_GROUP

export COSMOSDB_SQL_KEY=$(az cosmosdb keys list -n $COSMOSDB_SQL_ACCOUNT -g $AZ_RESOURCE_GROUP --query primaryMasterKey --output tsv)
export COSMOSDB_SQL_URL=$(az cosmosdb show -n $COSMOSDB_SQL_ACCOUNT -g $AZ_RESOURCE_GROUP --query documentEndpoint --output tsv)