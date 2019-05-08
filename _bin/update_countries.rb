#!/usr/bin/env ruby
require 'yaml'
require 'tcc_countries'

# build list of countries from YAML file
yaml_countries = YAML.safe_load(File.read('_data/countries.yaml')).map{|c| c['name']}

puts '## newly added: ##'
new = TccCountries.all - yaml_countries
puts new.map {|country| TccCountries::REGIONS.select{|region| TccCountries::COUNTRIES[region].include? country}[0] + ' :: ' + country}.sort

puts '## removed: ##'
puts yaml_countries - TccCountries.all