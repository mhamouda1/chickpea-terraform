@arguments = {}
@ES_HOST = ENV['ES_HOST'] #put in ~/.bash_profile

ARGV.each do |arg|
  arg = arg.chomp
  @arguments[arg.split("=").first] = arg.split("=").last
end

@new = {}
@arguments.each do |k,v|
  @new[k.downcase.split("_").first] ||= {}
  @new[k.downcase.split("_").first].merge!({k.downcase.split("_").last => v})
end

#delete the index for now, change to update later
`curl -XDELETE "http://#{@ES_HOST}:9200/chickpea"`

#create the index
`curl -XPUT "http://#{@ES_HOST}:9200/chickpea" -H 'Content-Type: application/json' -d'{  "settings": {    "index": {      "number_of_shards": 1,      "number_of_replicas": 0    }  }}'`

#index the data
@new.each do |k,v|
  `curl -XPOST "http://#{@ES_HOST}:9200/chickpea/_doc" -H 'Content-Type: application/json' -d'{"#{k}": #{v.to_json}}'`
end
