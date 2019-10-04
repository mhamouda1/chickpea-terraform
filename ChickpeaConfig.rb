module ChickpeaConfig
  def download_config(repo_name)
    config_repo = `cd ~/code && ls | grep #{repo_name}`
    `cd ~/code && git clone https://github.com/mhamouda1/#{repo_name}` if config_repo.empty?
  end

  def source_environment(repo_name, environment)
    `source ~/code/#{repo_name}/environments/#{environment}`
  end
end
