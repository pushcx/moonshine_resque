module Resque

  def redis(options = {})
    package 'redis-server', :ensure => 'absent'
    gem 'redis'
    gem 'resque' # needed for the rake test in the install step

    exec 'install redis',
      :cwd => '/tmp',
      :command => [
        'git clone git://github.com/defunkt/resque.git',
        'cd /tmp/resque',
        'rake redis:install dtach:install',
      ].join(' && '),
      :creates => '/usr/bin/redis-server'

    file '/etc/redis.conf',
      :content => template(File.join(File.dirname(__FILE__), '..', 'templates', 'redis.conf.erb'), binding),
      :ensure => :file,
      :mode => '644',
      :require => exec('install redis'),
      :notify => service('redis-server')

    service 'redis-server',
      :provider => :base,
      :start => '/usr/bin/redis-server',
      :pattern => 'redis-server',
      :ensure => :running,
      :enable => true,
      :require => file('/etc/redis.conf')
  end

  def resque(options = {} )
    gem 'resque'

    exec 'install resque',
      :require => service('redis-server')
  end
  
end
