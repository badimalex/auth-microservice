namespace :db do
  desc 'run seeds'

  task :seed, %i[version] => :settings do |t, args|

    require 'sequel/core'
    require "bcrypt"

    Sequel.connect(Settings.db.to_hash) do |db|
      items = db[:users]
      (1..10).each do |id|
        items.insert(
          name: "User#{id}",
          password_digest: BCrypt::Password.create(123456),
          email: "user-#{id}@gmail.com",
          created_at: DateTime.now,
          updated_at: DateTime.now,
        )
      end
    end
  end
end
