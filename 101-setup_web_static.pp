# web_static_setup.pp

class nginx {
  package { 'nginx':
    ensure => installed,
  }
}

file { ['/data', '/data/web_static', '/data/web_static/releases', '/data/web_static/shared', '/data/web_static/releases/test']:
  ensure => directory,
}

file { '/data/web_static/releases/test/index.html':
  content => '<html><head></head><body>Holberton School</body></html>',
}

file { '/data':
  ensure => directory,
  owner  => 'ubuntu',
  group  => 'ubuntu',
  recurse => true,
}

file { '/data/web_static/current':
  ensure  => link,
  target  => '/data/web_static/releases/test',
  force   => true,
  require => File['/data/web_static/releases/test/index.html'],
}

file { '/etc/nginx/sites-available/default':
  content => template('nginx/default.erb'),
  notify  => Service['nginx'],
}

service { 'nginx':
  ensure  => running,
  enable  => true,
  require => File['/etc/nginx/sites-available/default'],
}

class { 'nginx': }
