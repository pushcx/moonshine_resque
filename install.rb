# Install resque initializer

require 'fileutils'

# Workaround a problem with script/plugin and http-based repos.
# See http://dev.rubyonrails.org/ticket/8189
Dir.chdir(Dir.getwd.sub(/vendor.*/, '')) do

  [
    ["load_resque.conf", "config/initializers/"],
    ["resque.yml", "config/"],
  ].each do |file, to|
    FileUtils.cp "vendor/plugins/moonshine_resque/templates/#{file}", to
  end

end
