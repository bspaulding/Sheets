puts "Loading Roo Patches"
Dir[ File.join( File.expand_path(File.dirname(__FILE__)), 'roo_patches', '*.rb' ) ].each do |file|
  puts "- #{File.basename(file)}"
  require file
end