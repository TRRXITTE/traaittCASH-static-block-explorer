#!/bin/bash -e

# static explorer page generator
# (c)) TRRXITTE Int., incorporate, TRTL Team | 2020 - TODAY

# see LICENSE for details

HEIGHT=$(curl -s http://localhost:14486/getheight | jq '.height')
let "HEIGHT--"

cat ascii.txt
<br />
echo -e "\n### CURRENT BLOCK ###"<br />
curl -s http://localhost:14486/getheight | jq -r 'to_entries|map("\(.key) - \(.value|tostring)")|.[]'<br />
<br />
echo -e "\n### LAST BLOCK HEADER ###"<br />
curl -sd '{"jsonrpc":"2.0","method":"getlastblockheader","params":{}}' http://localhost:14486/json_rpc | jq -r .result.block_header | jq -r 'to_entries|map("\(.key) - \(.value|tostring)")|.[]'<br />
<br />
echo -e "\n### NETWORK INFO ###"<br />
curl -s http://localhost:14486/getinfo | jq -r 'to_entries|map("\(.key) - \(.value|tostring)")|.[]' <br />
<br />
echo -e "\n### PENDING TRANSACTIONS ###"<br />
curl -sd '{"jsonrpc":"2.0","method":"f_on_transactions_pool_json","params":{}}' http://localhost:14486/json_rpc | jq '.result.transactions[]' | jq -r 'to_entries|map("\(.key) - \(.value|tostring)")|.[]' <br />
<br />
echo -e "\n### LAST 10 BLOCKS ###"<br />
curl -sd '{"jsonrpc":"2.0","method":"f_blocks_list_json","params":{"height":'"$HEIGHT"'}}' http://localhost:14486/json_rpc | jq '.result.blocks' | jq '.[0:10]'<br />
<br />
cat footer.txt
