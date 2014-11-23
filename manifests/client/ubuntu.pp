#class nfs::client::ubuntu
class nfs::client::ubuntu inherits nfs::base {

  package { ["nfs-common", 'rpcbind']:
    ensure => present,
  }

  $portmap_service = versioncmp("${::operatingsystemrelease}", '13.10')? {
     0     => 'rpcbind',
     1     => 'rpcbind',
     default => 'portmap'
  }

  service { $portmap_service:
    ensure    => running,
    enable    => true,
    hasstatus => false,
    require   => Package["rpcbind"],
  }

}
