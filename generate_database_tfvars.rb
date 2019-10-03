require 'pry'
require 'json'

@resource = {"database" => nil}
@resource_name = @resource.keys[0]
@fields = ["name", "username", "password"]
@environments = ["development", "production", "default"]

@fields.each do |field|
  @resource[@resource_name] ||= {field => nil}
  @resource[@resource_name][field] = nil
end

@environments.each do |environment|
  @fields.each do |field|
    env_key = "#{environment.upcase}_#{@resource.keys[0].upcase}_#{field.upcase}"
    @resource[@resource_name][field] ||= {environment => nil}
    @resource[@resource_name][field][environment] = ENV[env_key] || "placeholder"
  end
end
-var-file=staging.tfvars

@resource = @resource.to_s
@resource.to_s[0] = ''
@resource[@resource.to_s.length - 1] = ''

File.open("blah.tfvars","w") do |f|
  # f.write(JSON.pretty_generate(@resource))
  f.write(@resource)
end

text = File.read("blah.tfvars")
# replace = text.gsub(/:/, "=")
replace = text.gsub(/=>/, " = ")
replace = replace.gsub(/\"#{@resource_name}\"/, "#{@resource_name}")
File.open("blah.tfvars", "w") {|file| file.puts replace}


# tempHash = {
    # "key_a" => "val_a",
    # "key_b" => "val_b"
# }
# @resource = @resource.to_json
# @resource = @resource.to_s.gsub(/\"database\"/, "database")


# require 'json'
# tempHash = {
    # "key_a" => "val_a",
    # "key_b" => "val_b"
# }
# File.open("temp.json","w") do |f|
  # f.write(JSON.pretty_generate(tempHash))
# end

# `touch blah.tfvars`
# `echo "#{JSON.pretty_generate(@resource)}" > blah.tfvars`
# `sed -i 's/:/ =/g' blah.tfvars`
