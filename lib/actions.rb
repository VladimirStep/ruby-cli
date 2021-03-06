require 'rubygems'
require 'commander/import'
require_relative 'model'

program :name, 'drkmen'
program :version, '0.0.1'
program :description, 'Create and list user places via CLI'

command :list do |c|
  c.syntax = 'drkmen list'
  c.summary = ''
  c.description = ''
  c.example 'description', 'command example'
  c.option '--some-switch', 'Some switch that does something'
  c.action do
    @places = Place.where(confirmation: true)
    if @places.count > 0
      puts "Found #{@places.count} offer."
      @places.each do |place|
        puts "#{place.identifier}: #{place.title}"
      end
    else
      puts 'No properties found.'
    end
  end
end

command :new do |c|
  c.syntax = 'drkmen new'
  c.summary = ''
  c.description = ''
  c.example 'description', 'command example'
  c.option '--some-switch', 'Some switch that does something'
  c.action do
    @place = Place.new(identifier: generate_identifier)
    @place.save(validate: false) if @place.valid_attribute?(:identifier)
    puts "Starting with new property #{@place.identifier}."
    create_attributes(@place)
  end
end

command :continue do |c|
  c.syntax = 'drkmen continue ABD159SD'
  c.summary = ''
  c.description = ''
  c.example 'description', 'command example'
  c.option '--some-switch', 'Some switch that does something'
  c.action do |args|
    @place = Place.find_by(identifier: args[0])
    if @place
      puts "Continuing with property #{@place.identifier}."
      create_attributes(@place)
    else
      puts 'No properties found.'
    end
  end
end

def generate_identifier
  charset = Array('A'..'Z') + Array('1'..'9')
  Array.new(8) { charset.sample }.join
end

def create_attributes(place)
  attributes = place.attribute_names
  attributes.each do |attribute_name|
    unless place[attribute_name] || attribute_name == 'confirmation'
      while place[attribute_name].nil?
        input = ''
        input = ask(PROMPTS[attribute_name.to_sym])
        place[attribute_name] = input
        if place.valid_attribute?(attribute_name)
          place.save(validate: false)
          place.check_for_confirmation
        else
          puts place.errors[attribute_name]
          place[attribute_name] = nil
        end
      end
    end
  end
end
