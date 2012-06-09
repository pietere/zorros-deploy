require 'spec_helper'
require 'grit'

describe Zorros::Deploy do
  before do
    AppsFactory.create_repo
    AppsFactory.create_app
    AppsFactory.deploy_app
  end

  it 'tags the repo with todays date' do
    repo = Grit::Repo.new AppsFactory.app_dir
    repo.tags.first.name.should eq('2012-06-09')
  end
end
