Capistrano::Configuration.instance(:must_exist).load do

  # Create a task after updating the code
  after "deploy:update_code", "zorros:tag_release"

  namespace :zorros do
    desc "Create a GIT tag on each deploy"
    task :tag_release do
      tag_name = Time.now.strftime("deploy_%d-%m-%Y")

      system "git tag -a -m 'Deployment on #{Time.now.strftime("%d-%m-%Y")}' #{tag_name}"
    end
  end
end

