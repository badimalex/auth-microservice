namespace :db do
  desc 'run migrations'

  task :migrate, %i[version] => :settings do |t, args|

    require 'sequel/core'
    Sequel.extension :migration

    Sequel.connect(Settings.db.to_hash) do |db|
      db.extension :schema_dumper

      migrations = File.expand_path('../../db/migrations', __dir__)
      version = args.version.to_i if args.version

      Sequel::Migrator.run(db, migrations, target: version)

      schema = db.dump_schema_migration
      File.open("db/schema.rb", 'w') {|f| f.write(schema) }
    end
  end
end
