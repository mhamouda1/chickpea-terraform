require 'pry'
require 'securerandom'
require 'json'

@delete_previous_fields = true

@resource_name = "database"
@name = "appmysql"
@fields = ["name", "username", "password", "environment"]
@environments = ["production", "default", "staging", "uat", "development"]
@host = "157.245.224.16"

@resources = []
@environments.each do |environment|
  #has to be inside block, otherwise @resources will be same values
  @resource = {}
  @resource[@resource_name] ||= {}

  @resource[@resource_name]["name"] = "#{@name}"
  @resource[@resource_name]["environment"] = "#{environment}"
  @resource[@resource_name]["username"] = "#{SecureRandom.hex}"
  @resource[@resource_name]["password"] = "#{SecureRandom.hex}"
  @resources << @resource
end

p `curl -XPOST "http://#{@host}:9200/chickpea/_delete_by_query" -H 'Content-Type: application/json' -d'{  "query": {    "match": {      "database.name": "'#{@name}'"    }  }}'` if @delete_previous_fields

#index the environment variables
@resources.each do |resource|
  p `curl -XPOST "http://#{@host}:9200/chickpea/_doc/" -H 'Content-Type: application/json' -d'#{resource.to_json}'`
end
