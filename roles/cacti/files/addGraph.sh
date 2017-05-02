#!/bin/bash

CACTI_DIR=/usr/share/cacti/

NODE=$1
GRAPH_STRING=$2
PREFIX=$3

NODE_ID=`$CACTI_DIR/cli/add_graphs.php --list-hosts | grep $NODE | cut -f 1`
GRAPH_ID=`$CACTI_DIR/cli/add_graphs.php --list-graph-templates | grep "$GRAPH_STRING" | cut -f 1`
$CACTI_DIR/cli/add_graphs.php --graph-template-id=$GRAPH_ID  --host-id=$NODE_ID --input-fields="prefix=$PREFIX" --graph-type=cg


exit 0
