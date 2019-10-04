# export $1 #resource
# export $2 #name
# export $3 #
# export $4

# resource=$1
# name=$2
# environment=$3
# field=$4


# x=$(curl -XPOST "http://157.245.224.16:9200/chickpea/_search" -H 'Content-Type: application/json' -d'{  "query": {    "bool" : {      "must": [        { "term" : { "database.name": "database2" } }      ]    }  }}' | jq .hits.hits[0]._source.database.credentials[0].password -r)
# echo $x
echo $1
curl -XPOST "http://157.245.224.16:9200/chickpea/_search" -H 'Content-Type: application/json' -d'{  "query": {    "bool" : {      "must": [        { "term" : { "'$1'.name": "'$2'" } }      ]    }  }}'
