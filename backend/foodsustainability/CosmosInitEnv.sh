#!/bin/bash
# Author  : Mark A. Heckler
# Notes   : Run with 'source CosmosInitEnv.sh' from your shell/commandline environment
# History : Official "version 1" 20220818.

# REQUIREMENTS
## Azure CLI (az)

# Your Azure ID
export AZUREID='f6b6dd5b-f02f-441a-99a0-162ac5060bd2'

# Establish seed for random naming
export RANDOMIZER=$RANDOM

# Azure subscription to use
export AZ_SUBSCRIPTION='3f292da3-e43c-4318-9401-1dc710f55936'
# export AZ_RESOURCE_GROUP=$AZUREID'-'$RANDOMIZER'-rg'
export AZ_RESOURCE_GROUP='Food_Sustainability'
export AZ_LOCATION='westus'

# Database
export COSMOSDB_SQL_ACCOUNT=$AZUREID'-'$RANDOMIZER'-sqlacct'
export COSMOSDB_SQL_NAME=$AZUREID'-'$RANDOMIZER'-sqldb'
export COSMOSDB_CONTAINER='container1'
export COSMOSDB_DATA_PART='/name/last'
export COSMOSDB_SQL_KEY='Cg7g5b6GBnLUXttConKkAHt779EWi7sNYJrvodRplVUndCbJYphrjGZnFtQma0HGvtCGdn3eQqsRACDbiXwyMA=='
export COSMOSDB_SQL_URL='https://foodsustainability.documents.azure.com:443/'