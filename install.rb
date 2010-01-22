# Install resque initializer

# Workaround a problem with script/plugin and http-based repos.
# See http://dev.rubyonrails.org/ticket/8189
Dir.chdir(Dir.getwd.sub(/vendor.*/, '')) do

  source = File.join(File.dirname(__FILE__), 'vendor', 'plugins', 'moonshine_resque')
  [
    ["load_resque.conf", "config/initializers/"],
    ["resque.conf", "config/"],
  ].each do |file, to|
    FileUtils.cp "vendor/plugins/moonshine_resque/#{file}", to
  end

end
