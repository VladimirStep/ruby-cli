require 'sqlite3'
require 'active_record'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: './../db/db.sqlite3')

ActiveRecord::Schema.define do
  unless ActiveRecord::Base.connection.data_source_exists? 'places'
    create_table 'places' do |t|
      t.string 'identifier'
      t.string 'title'
      t.string 'address'
      t.string 'app_type'
      t.integer 'rate'
      t.integer 'capacity'
      t.string 'email'
      t.string 'phone'
      t.boolean  'confirmation', default: false
    end
  end
end

class Place < ActiveRecord::Base
  validates :identifier, uniqueness: true
  validates :title, presence: true, length: { minimum: 2, maximum: 20 }
  validates :address, presence: true, length: { minimum: 2, maximum: 50 }
  validates :app_type, presence: true, inclusion: { in: ['holiday home', 'apartment', 'private room'] }
  validates :rate, presence: true, numericality: { only_integer: true }
  validates :capacity, presence: true, numericality: { only_integer: true }
  validates :email, presence: true, length: { minimum: 2, maximum: 20 }
  validates :phone, presence: true, length: { minimum: 5, maximum: 10 }

  def valid_attribute?(attribute_name)
    self.valid?
    self.errors[attribute_name].blank?
  end

  def check_for_confirmation
    if self.valid?
      self.confirmation = true
      self.save
      puts "Great job! Listing #{self.identifier} is complete!"
    end
  end
end

PROMPTS = { title: 'Title: ',
            address: 'Address: ',
            app_type: 'Property type: ',
            rate: 'Nightly rate in EUR: ',
            capacity: 'Max guests: ',
            email: 'Email: ',
            phone: 'Phone number: ' }