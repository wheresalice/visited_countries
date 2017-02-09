require 'nokogiri'
require 'open-uri'
require 'yaml'


page = Nokogiri::HTML(open('http://travelerscenturyclub.org/countries-and-territories'))

# build list of countries from TCC webpage
page_countries = []
page.css("td[width='50%'] li").each do |country|
  page_countries << country.text
end
page_countries.sort!

# build list of countries from YAML file
yaml_countries = YAML.safe_load(File.read('_data/countries.yaml')).map{|c| c['name']}

puts '## newly added: ##'
puts page_countries - yaml_countries

puts '## removed: ##'
puts yaml_countries - page_countries