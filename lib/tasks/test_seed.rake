namespace :db do
  namespace :test do
    task :prepare => :environment do
      Rake::Task["db:seed"].invoke
    end
  end

  namespace :fixtures do
    namespace :load do 
      ENV['FIXTURES_PATH'] = "spec/fixtures"
      ENV['RAILS_ENV'] ||= "test"
      puts ENV.inspect
    end
  end
end
