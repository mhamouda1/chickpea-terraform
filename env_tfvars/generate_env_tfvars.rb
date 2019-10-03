require 'pry'
require 'json'
require 'pp'

@path = "env_tfvars"
@resource = {"database" => nil}
@resource_name = @resource.keys[0]
@fields = ["name", "username", "password"]
@environments = ["production", "staging"]

@environments.each do |environment|
  @resource[@resource_name] ||= {environment => nil}
  @resource[@resource_name][environment] = nil
end


@environments.each do |environment|
  @fields.each do |field|
    env_key = "#{environment.upcase}_#{@resource.keys[0].upcase}_#{field.upcase}"
    @resource[@resource_name][environment] ||= {field => nil}
    @resource[@resource_name][environment][field] = ENV[env_key] || "placeholder"
  end
end

@environments.each do |environment|
  @fields.each do |field|
    File.open("#{@path}/#{environment}.tfvars","w+") do |f|
      @values = @resource[@resource.keys[0]][environment]
        f << "#{@resource.keys[0]} = {\n"
        @values.each do |h,k|
          f << "  #{h} = \"#{k}\"\n"
        end
        f << "}"
    end
  end
end
