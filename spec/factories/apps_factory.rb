class AppsFactory
  class << self
    attr_reader :repo_dir, :app_dir

    def reset_test_app
      @test_files_dir = File.join(Dir.pwd, "test_files")
      @app_dir  = File.join(@test_files_dir, "app")
      @repo_dir = File.join(@test_files_dir, "repo")

      FileUtils.rm_r(@test_files_dir) if File.exists?(@test_files_dir)
      FileUtils.mkdir_p(@test_files_dir)
    end

    def create_repo
      FileUtils.mkdir_p @repo_dir
      Dir.chdir(@repo_dir) do
        run_command "git --bare init"
      end
    end

    def create_app
      # Create and capify the dummy app and push it to the local repo
      FileUtils.mkdir_p @app_dir
      Dir.chdir(@app_dir) do
        [
          %Q{git init},
          %Q{mkdir config},
          %Q{capify .},
          %Q{git add .},
          %Q{git commit -m "first commit"},
          %Q{git remote add origin file://#{@repo_dir}},
          %Q{git push origin master}
        ].each do |command|
          run_command command
        end
      end

      # Write a custom deploy file to the app, using an ERB template
      deploy_variables = {
        :deploy_to => File.join(@test_files_dir, "deployed"),
        :repository => @repo_dir,
        :git_executable => `which git`.strip,
        :logged_in_user => Etc.getlogin
      }

      template_path     = File.expand_path(File.join(__FILE__, "..", "templates", "deploy.erb"))
      compiled_template = ERB.new(File.read(template_path)).result(binding)

      File.open(File.join(@app_dir, "config", "deploy.rb"), 'w') {|f| 
        f.write compiled_template
      }
    end

    def deploy_app
      Dir.chdir(@app_dir) do
        run_command 'cap deploy:setup'
        run_command 'cap deploy'
      end
    end

    protected

    def silence_stream(stream)
      old_stream = stream.dup
      stream.reopen(RbConfig::CONFIG['host_os'] =~ %r{mswin|mingw} ? 'NUL:' : '/dev/null')
      stream.sync = true
      yield
    ensure
      stream.reopen(old_stream)
    end

    def quietly
      silence_stream(STDOUT) do
        silence_stream(STDERR) do
          yield
        end
      end
    end

    def run_command(command)
      quietly{ system(command) }
    end
  end
end
