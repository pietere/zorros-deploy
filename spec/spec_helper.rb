require 'rubygems'

$LOAD_PATH << File.expand_path("../lib", File.dirname(__FILE__))

require 'factories/apps_factory'

RSpec.configure do |config|
  config.before(:each){ AppsFactory.reset_test_app }
end
