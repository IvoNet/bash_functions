#!/usr/bin/env bash

die() {
    echo "$@"
    exit 1
}
if [ -z "$1" ]; then
    die "[ERROR] Please read the test to learn how to use me.\nNo first parameter provided. This function expects two"
fi
if [ ! -f "$1" ]; then
    die "[ERROR] Please read the test to learn how to use me.\nThe first parameter should be a yaml file and exist."
fi
if [ -z "$2" ]; then
    die "[ERROR] Please read the test to learn how to use me.\nNo second param provided. This function expects two"
fi

YAML="$1"
PREFIX="$2"

parse_yaml() {
   # syntax: parse_yaml path_to_yaml_file.yml [prefix]
   # This parser demands a 2 space indent no more no less.
   if [ -z "$2" ]; then
      local prefix="yml_"
   else
      local prefix=$2_
   fi
   local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
   sed -ne "s|^\($s\)\($w\)$s:$s\"\(.*\)\"$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
   awk -F$fs '{
      indent = length($1)/2;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
         printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
      }
   }'
}

eval $(parse_yaml "${YAML}" "${PREFIX}")