#change this script to generate json, #{env}.auto.tfvars.json file works
require 'bundler/setup'
Bundler.require(:default)

require_relative 'ChickpeaConfig'
include ChickpeaConfig

@repo_name = "chickpea-config"
@environments = `ls ~/code/#{@repo_name}/environments/*`.split("\n")

@environments.map! { |environment| environment.split("/").last }
download_config(@repo_name)
@environments.each do |environment|
  source_environment(@repo_name, environment)
end

# binding.pry


# ``
# @resource_name = "database"
# @fields = ["name", "username", "password"]
# @environments = ["production", "default"]

# #create hash
# @resource = {@resource_name => nil}
# @environments.each do |environment|
  # @resource[@resource_name] ||= {environment => nil}
  # @resource[@resource_name][environment] = nil
# end

# #grab env variable from linux
# @environments.each do |environment|
  # @fields.each do |field|
    # env_key = "#{environment.upcase}_#{@resource.keys[0].upcase}_#{field.upcase}"
    # @resource[@resource_name][environment] ||= {field => nil}
    # @resource[@resource_name][environment][field] = ENV[env_key] || "placeholder"
  # end
# end

# #write to file in terraform format
# @environments.each do |environment|
  # @fields.each do |field|
    # extension = environment == "default" ? ".auto.tfvars" : ".tfvars"

    # File.open(environment + extension,"w+") do |f|
      # @values = @resource[@resource_name][environment]
        # f << "#{@resource_name} = {\n"
        # @values.each do |h,k|
          # f << "  #{h} = \"#{k}\"\n"
        # end
        # f << "}"
    # end
  # end
# end
