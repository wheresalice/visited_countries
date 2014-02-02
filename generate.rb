require 'csv'

Dir.glob('_data/*.yaml').each {|f| File.unlink(f) } 

visited_countries = 0
countries = 0

CSV.foreach("TCC Countries - The Big List.csv") do |row|
  File.open(File.join('_data', "#{row[2].gsub(' ','_').gsub('&','and').downcase}.yaml"), 'a') do |f|
    f.write("- name: #{row[0]}\n  visited: #{row[1] || 0}\n  region: #{row[2]}")
    f.write("\n\n")
    visited_countries +=1 unless row[1].nil?
    countries += 1
  end
end

File.open('_includes/count.md', 'w') do |f|
  
  f.write "visited countries: #{visited_countries}<br>\n"
  f.write "countries left for provisional TCC membership: #{75 - visited_countries}<br>\n"
  f.write "countries left for full TCC membership: #{100 - visited_countries }<br>\n"
  f.write "percentage of countries visited: #{(( visited_countries.to_f / countries) * 100).round(2)}%<br>\n"
end