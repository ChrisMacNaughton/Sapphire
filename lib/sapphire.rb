module Sapphire
  
end

Dir["#{File.expand_path('../',  __FILE__)}/**/*.rb"].each do |filename|
  next if filename =~ /sapphire.rb\z/
  require filename.gsub('.rb', '')
end