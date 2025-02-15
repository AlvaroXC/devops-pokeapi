#!/bin/bash

if [ "$#" -eq 0 ]
then 
    echo "No se proporciono un nombre de pokemon"
    exit 1
fi

pokename="$1"

response=$(curl "https://pokeapi.co/api/v2/pokemon/$pokename") 

if ["$response"=="Not Found"]
then
    echo "No se encontró información"
    exit 1
fi

name=$(echo "$response" | jq -r '.name')
id=$(echo "$response" | jq -r '.id')
order=$(echo "$response" | jq -r '.order')
height=$(echo "$response" | jq -r '.height')
weight=$(echo "$response" | jq -r '.weight')

echo "$name (No. $order) "
echo "Id = $id"
echo "Weight = $weigth "
echo "Height = $height"

csv_name = "pokemon.csv"
if [ -f "$csv_name" ]
then
    echo "$id,$name,$order,$height,$weight" >> pokemon.csv
else
    touch pokemon.csv
    echo "id,name,order,height,weight" > pokemon.csv
    echo "$id,$name,$order,$height,$weight" >> pokemon.csv
fi