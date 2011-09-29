require 'git'
Capistrano::Configuration.instance(:must_exist).load do

  # Create a tag after updating the code
  after "deploy:update_code", "zorros:tag_release"
  after "deploy:migrations", "zorros:tag_release"

  namespace :zorros do
    desc "Create a GIT tag on each deploy"
    task :tag_release do
      git = Git.open "."
      tag_date = Time.now.strftime("%d-%m-%Y")
      tag_number = git.tags.collect { |t| t.name =~ %r{#{tag_date}} }.compact.size

      tag_name = if tag_number > 0
                   "#{tag_date}.#{tag_number}"
                 else
                   tag_date
                 end

      git.add_tag tag_name
      git.push "origin", "master", true
    end
  end
end

