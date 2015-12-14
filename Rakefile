require "rake/testtask"
require "logger"
require "./config/sequel"

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList["test/**/*_test.rb"]
end

task :default => :test

desc "Start the console with app loaded, in sandbox mode"
task :console do
  ARGV.clear
  $: << "#{__dir__}/lib"

  require "./config/sequel"
  require "toastmasters"
  require "pry"
  require "logger"

  include Toastmasters::Models
  DB.logger = Logger.new(STDOUT)
  DB.transaction(rollback: :always) { Pry.start }
end

namespace :db do
  desc "Migrate the database (you can specify the version with `db:migrate[N]`)"
  task :migrate, [:version] do |task, args|
    version = args[:version] ? Integer(args[:version]) : nil
    migrate(version)
    dump_schema
  end

  desc "Undo all migrations"
  task :demigrate do
    migrate(0)
    dump_schema
  end

  desc "Undo all migrations and migrate again"
  task :remigrate do
    migrate(0)
    migrate
    dump_schema
  end

  def migrate(version = nil)
    Sequel.extension :migration
    log { Sequel::Migrator.apply(DB, "db/migrations", version) }
  end

  def dump_schema
    return if ENV["RACK_ENV"] == "production"
    system "pg_dump #{DB.opts[:database]} > db/schema.sql"
    DB.extension :schema_dumper
    File.write("db/schema.rb", DB.dump_schema_migration(same_db: true))
  end

  def log
    DB.logger = Logger.new($stdout)
    yield
    DB.logger = nil
  end
end
