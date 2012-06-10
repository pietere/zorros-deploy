require 'spec_helper'
require 'grit'

describe Zorros::Deploy do
  context 'deploying from master' do
    before do
      AppsFactory.create_repo
      AppsFactory.create_app
      AppsFactory.deploy_app
    end

    it "tags the repo with today's date" do
      repo = Grit::Repo.new AppsFactory.app_dir
      today = Time.now.strftime('%Y-%m-%d')

      repo.tags.first.name.should eq(today)
    end
  end
end
