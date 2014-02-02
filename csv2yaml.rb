require 'csv'

Dir.glob('_data/*.yaml').each {|f| File.unlink(f) } 

CSV.foreach("TCC Countries - The Big List.csv") do |row|
  File.open(File.join('_data', "#{row[2].gsub(' ','_').gsub('&','and').downcase}.yaml"), 'a') do |f|
    f.write("- name: #{row[0]}\n  visited: #{row[1] || 0}\n  region: #{row[2]}")
    f.write("\n\n")
  end
end