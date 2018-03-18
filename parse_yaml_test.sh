#!/bin/sh

. parse_yaml.sh ./parse_yaml_test.yml test

echo "Printing parsed yml values..."
echo "test_application_name   : $test_application_name"
echo "test_application_version: $test_application_version"
echo "test_verbose            : $test_verbose"
echo "test_tree_levels_deep   : $test_tree_levels_deep"

