require 'pry'
require 'securerandom'
require 'json'

@delete_previous_fields = true

@resource_name = "database"
@name = "chickpea-mysql"
@fields = ["name", "username", "password", "environment"]
@environments = ["production", "default", "staging", "uat", "development"]
@host = "157.245.224.16"

@environments.each do |environment|
  #the query
  @response = JSON.parse(`curl -XPOST "http://#{@host}:9200/chickpea/_search" -H 'Content-Type: application/json' -d'{  "query": {    "bool": {      "must": [        {          "term": {            "database.name.keyword": "'#{@name}'"          }        },        {          "term": {            "database.environment.keyword": "'#{environment}'"          }        }      ]    }  }}'`)

  @response_object = @response["hits"]["hits"][0]["_source"]
  File.open("#{environment}.tfvars.json","w") do |f|
    f.write(JSON.pretty_generate(@response_object))
  end
end
