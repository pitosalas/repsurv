namespace :db do
  namespace :test do
    desc "from task_modifiers.rake"
    task :prepare => :environment do
      Rake::Task["db:seed"].invoke
    end
  end
end

namespace :load do
  namespace :test do
    desc "task_modifiers.rake"
    task :fixtures => :environment do
    Rails.env = "test"
      ENV['FIXTURES_PATH'] = "spec/fixtures"
      Rake::Task["db:fixtures:load"].invoke
    end
  end
end

namespace :app do
  namespace :seed do
    desc "load sample data based on jbs stuff"
    task :load => [:environment, "db:seed"] do
      %w(round participant program question user response).map { |name| seed_table_with_data name }
    end
  end

  def seed_table_with_data name
    puts "Clearing and loading table: #{name}"
    name.capitalize.constantize.delete_all
    require Rails.root + "db/seeds/" + (name.pluralize + ".rb")
  end
end