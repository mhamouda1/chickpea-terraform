@env_file_path = "../chickpea-app/kubernetes/production.env"

ARGV.each do |arg|
  field, value = arg.split("=")
  if `cat "#{@env_file_path}" | grep #{field} | wc -l`.to_i == 1 #does the field exist in the file?
    @new_file = `cat "#{@env_file_path}"`.gsub(/#{field}.*\n/, field + "=" + value + "\n") #if so, replace with new value
  else
    @new_file = `cat "#{@env_file_path}"` + field + "=" + value + "\n" #if not, add new field=value
  end
  `echo "#{@new_file.gsub(/\n+/, "\n").chomp}" > #{@env_file_path}` #fix newline formatting and write file
end
