namespace :db do
  namespace :test do
    task :prepare => :environment do
      Rake::Task["db:seed"].invoke
    end
  end
end

namespace :load do
  namespace :test do
    task :fixtures => :environment do
    Rails.env = "test"
      ENV['FIXTURES_PATH'] = "spec/fixtures"
      Rake::Task["db:fixtures:load"].invoke
    end
  end
end

