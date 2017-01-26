require 'sqlite3'
require 'active_record'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: '../db.sqlite3')

ActiveRecord::Schema.define do
  unless ActiveRecord::Base.connection.tables.include? 'places'
    create_table 'places' do |t|
      t.string 'title'
      t.string 'type'
      t.string 'address'
      t.integer 'rate'
      t.integer 'capacity'
      t.string 'email'
      t.string 'phone'
    end
  end
end

class Place < ActiveRecord::Base

end