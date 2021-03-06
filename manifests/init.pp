# = Class: munin
#
# This is the main munin class
#
# == Module specific parameters
#
# [*server*]
#   Ip of Munin server
#
# [*server_local*]
#   If the local host is a Munin server
#
# [*folder*]
#   Specify a "folder" or group of servers to display in the munin web interface
#
# [*grouplogic*]
#   The name of the variable to use as identifier of different group of nodes
#   that should be monitored by the same server.
#
# [*address*]
#   The ip address that's provided to the munin server in the Exported 
#   Resource
#   Defaults to $ipaddress.
#
# [*extra_plugins*]
#   Boolean that defines if you want to add some extra plugins provided
#   by the module. Default: false
#
# [*graph_strategy*]
#   graph_strategy denotes whether the graphs are created every five minutes from cron
#   or on demand when loading the webpage with a CGI script. Please note that you have
#   to configure the web server separately.
#   Allowed: cron (the default) or cgi
#
# [*graph_period*]
#   graph_period is an optional attribute, which control the unit of the data 
#   that will be displayed with in the graphs. The default is per second. 
#   Changing to per minute is useful in cases of a low frequency of whatever 
#   the plugin is measuring. 
#   Allowed: second (the default), minute or hour
#
# [*autoconfigure*]
#   Boolean that defines if you want to autoconfigure plugins: Default: true
#   If true a nightly cron jobs re-runs the munin autoconfigure script.
#   Set to 'once' to run the autoconfigure only when installing or upgrading
#   the package.
#
# [*package_perlcidr*]
#   Name of the Perl-Net CIDR package, required by the module for Munin
#   Set it to blank ('') if you don't want it (default templates need it)
#
# [*package_server*]
#   Name of the Munin server package
#
# [*config_file_server*]
#   Path of the server's configuration file
#
# [*template_server*]
#   Custom template to use for the server configuration file
#
# [*include_dir*]
#   Directory that includes extra configuration files. For example the exported host configurations land here.
#
# [*include_dir_purge*]
#   Boolean to indicate that only puppet-managed extra configuration files should be accepted. Default: false.
#
# [*conf_dir_plugins*]
#   Directory with extra plugins configurations
#
# [*web_dir*]
#   Directory where Munin graphs are stored for Web publication
#
# [*conf_dir_active_plugins*]
#   Directory containing the links to the active Plugins
#   This is autogenerated daily
#
# [*plugins_dir*]
#   Directory where the Munin plugins are stored
#
#
# == Parameters
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, munin class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $munin_myclass
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, munin main config file will have the param: source => $source
#   Can be defined also by the (top scope) variable $munin_source
#
# [*source_dir*]
#   If defined, the whole munin configuration directory content is retrieved
#   recursively from the specified source
#   (source => $source_dir , recurse => true)
#   Can be defined also by the (top scope) variable $munin_source_dir
#
# [*source_dir_purge*]
#   If set to true (default false) the existing configuration directory is
#   mirrored with the content retrieved from source_dir
#   (source => $source_dir , recurse => true , purge => true)
#   Can be defined also by the (top scope) variable $munin_source_dir_purge
#
# [*template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, munin main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the (top scope) variable $munin_template
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the (top scope) variable $munin_options
#
# [*service_autorestart*]
#   Automatically restarts the munin service when there is a change in
#   configuration files. Default: true, Set to false if you don't want to
#   automatically restart the service.
#
# [*version*]
#   The package version, used in the ensure parameter of package type.
#   Default: present. Can be 'latest' or a specific version number.
#   Note that if the argument absent (see below) is set to true, the
#   package is removed, whatever the value of version parameter.
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $munin_absent
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#   Can be defined also by the (top scope) variable $munin_disable
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by a tool like a cluster software
#   Can be defined also by the (top scope) variable $munin_disableboot
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the (top scope) variables $munin_monitor
#   and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module)
#   you want to use for munin checks
#   Can be defined also by the (top scope) variables $munin_monitor_tool
#   and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools.
#   Default is the fact $ipaddress
#   Can be defined also by the (top scope) variables $munin_monitor_target
#   and $monitor_target
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the (top scope) variables $munin_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module
#   is specified in params.pp and is generally a good choice.
#   You can customize the output of puppi commands for this module using another
#   puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the (top scope) variables $munin_puppi_helper
#   and $puppi_helper
#
# [*firewall*]
#   Set to 'true' to enable firewalling of the services provided by the module
#   Can be defined also by the (top scope) variables $munin_firewall
#   and $firewall
#
# [*firewall_tool*]
#   Define which firewall tool(s) (ad defined in Example42 firewall module)
#   you want to use to open firewall for munin port(s)
#   Can be defined also by the (top scope) variables $munin_firewall_tool
#   and $firewall_tool
#
# [*firewall_src*]
#   Define which source ip/net allow for firewalling munin. Default: 0.0.0.0/0
#   Can be defined also by the (top scope) variables $munin_firewall_src
#   and $firewall_src
#
# [*firewall_dst*]
#   Define which destination ip to use for firewalling. Default: $ipaddress
#   Can be defined also by the (top scope) variables $munin_firewall_dst
#   and $firewall_dst
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the (top scope) variables $munin_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the (top scope) variables $munin_audit_only
#   and $audit_only
#
# Default class params - As defined in munin::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*package*]
#   The name of munin package
#
# [*service*]
#   The name of munin service
#
# [*service_status*]
#   If the munin service init script supports status argument
#
# [*process*]
#   The name of munin process
#
# [*process_args*]
#   The name of munin arguments. Used by puppi and monitor.
#   Used only in case the munin process name is generic (java, ruby...)
#
# [*process_user*]
#   The name of the user munin runs with. Used by puppi and monitor.
#
# [*config_dir*]
#   Main configuration directory. Used by puppi
#
# [*config_file*]
#   Main configuration file path
#
# [*config_file_mode*]
#   Main configuration file path mode
#
# [*config_file_owner*]
#   Main configuration file path owner
#
# [*config_file_group*]
#   Main configuration file path group
#
# [*config_file_init*]
#   Path of configuration file sourced by init script
#
# [*pid_file*]
#   Path of pid file. Used by monitor
#
# [*data_dir*]
#   Path of application data directory. Used by puppi
#
# [*log_dir*]
#   Base logs directory. Used by puppi
#
# [*log_file*]
#   Log file(s). Used by puppi
#
# [*port*]
#   The listening port, if any, of the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Note: This doesn't necessarily affect the service configuration file
#   Can be defined also by the (top scope) variable $munin_port
#
# [*protocol*]
#   The protocol used by the the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Can be defined also by the (top scope) variable $munin_protocol
#
#
# == Examples
#
# You can use this class in 2 ways:
# - Set variables (at top scope level on in a ENC) and "include munin"
# - Call munin as a parameterized class
#
# See README for details.
#
#
# == Author
#   Alessandro Franceschi <al@lab42.it/>
#
class munin (
  $server              = params_lookup( 'server' ),
  $server_local        = params_lookup( 'server_local' ),
  $folder              = params_lookup( 'folder' ),
  $grouplogic          = params_lookup( 'grouplogic' ),
  $address             = params_lookup( 'address' ),
  $extra_plugins       = params_lookup( 'extra_plugins' ),
  $graph_strategy      = params_lookup( 'graph_strategy' ),
  $graph_period        = params_lookup( 'graph_period' ),
  $autoconfigure       = params_lookup( 'autoconfigure' ),
  $restart_or_reload   = params_lookup( 'restart_or_reload' ),
  $package_perlcidr    = params_lookup( 'package_perlcidr' ),
  $package_server      = params_lookup( 'package_server' ),
  $config_file_server  = params_lookup( 'config_file_server' ),
  $template_server     = params_lookup( 'template_server' ),
  $template_host       = params_lookup( 'template_host' ),
  $include_dir         = params_lookup( 'include_dir' ),
  $include_dir_purge   = params_lookup( 'include_dir_purge' ),
  $conf_dir_plugins    = params_lookup( 'conf_dir_plugins' ),
  $conf_dir_active_plugins = params_lookup( 'conf_dir_active_plugins' ),
  $web_dir             = params_lookup( 'web_dir' ),
  $plugins_dir         = params_lookup( 'plugins_dir' ),
  $my_class            = params_lookup( 'my_class' ),
  $source              = params_lookup( 'source' ),
  $source_dir          = params_lookup( 'source_dir' ),
  $source_dir_purge    = params_lookup( 'source_dir_purge' ),
  $template            = params_lookup( 'template' ),
  $service_autorestart = params_lookup( 'service_autorestart' , 'global' ),
  $options             = params_lookup( 'options' ),
  $version             = params_lookup( 'version' ),
  $absent              = params_lookup( 'absent' ),
  $disable             = params_lookup( 'disable' ),
  $disableboot         = params_lookup( 'disableboot' ),
  $monitor             = params_lookup( 'monitor' , 'global' ),
  $monitor_tool        = params_lookup( 'monitor_tool' , 'global' ),
  $monitor_target      = params_lookup( 'monitor_target' , 'global' ),
  $puppi               = params_lookup( 'puppi' , 'global' ),
  $puppi_helper        = params_lookup( 'puppi_helper' , 'global' ),
  $firewall            = params_lookup( 'firewall' , 'global' ),
  $firewall_tool       = params_lookup( 'firewall_tool' , 'global' ),
  $firewall_src        = params_lookup( 'firewall_src' , 'global' ),
  $firewall_dst        = params_lookup( 'firewall_dst' , 'global' ),
  $debug               = params_lookup( 'debug' , 'global' ),
  $audit_only          = params_lookup( 'audit_only' , 'global' ),
  $package             = params_lookup( 'package' ),
  $service             = params_lookup( 'service' ),
  $service_status      = params_lookup( 'service_status' ),
  $process             = params_lookup( 'process' ),
  $process_args        = params_lookup( 'process_args' ),
  $process_user        = params_lookup( 'process_user' ),
  $config_dir          = params_lookup( 'config_dir' ),
  $config_file         = params_lookup( 'config_file' ),
  $config_file_mode    = params_lookup( 'config_file_mode' ),
  $config_file_owner   = params_lookup( 'config_file_owner' ),
  $config_file_group   = params_lookup( 'config_file_group' ),
  $config_file_init    = params_lookup( 'config_file_init' ),
  $pid_file            = params_lookup( 'pid_file' ),
  $data_dir            = params_lookup( 'data_dir' ),
  $log_dir             = params_lookup( 'log_dir' ),
  $log_file            = params_lookup( 'log_file' ),
  $port                = params_lookup( 'port' ),
  $protocol            = params_lookup( 'protocol' )
  ) inherits munin::params {

  $bool_server_local=any2bool($server_local)
  $bool_extra_plugins=any2bool($extra_plugins)
  $bool_autoconfigure= $autoconfigure ? {
    'once'  => false,
    default => any2bool($autoconfigure),
  }

  $bool_source_dir_purge=any2bool($source_dir_purge)
  $bool_include_dir_purge=any2bool($include_dir_purge)
  $bool_service_autorestart=any2bool($service_autorestart)
  $bool_absent=any2bool($absent)
  $bool_disable=any2bool($disable)
  $bool_disableboot=any2bool($disableboot)
  $bool_monitor=any2bool($monitor)
  $bool_puppi=any2bool($puppi)
  $bool_firewall=any2bool($firewall)
  $bool_debug=any2bool($debug)
  $bool_audit_only=any2bool($audit_only)

  ### Definition of some variables used in the module
  $array_servers = is_array($munin::server) ? {
    false     => $munin::server ? {
      ''      => [],
      default => split($munin::server, ','),
    },
    default   => $munin::server,
  }

  ### Prepare folder for use in template
  $folder_prefix = $munin::folder ? {
    ''      => '',
    default => "${munin::folder};",
  }

  ### Grouping tag
  $magic_tag = get_magicvar($munin::grouplogic)

  $manage_package = $munin::bool_absent ? {
    true  => 'absent',
    false => $munin::version,
  }

  # non-src:munin packages fail to install when a specific munin version is specified
  $manage_aux_package = $munin::bool_absent ? {
    true  => 'absent',
    false => 'present',
  }

  $manage_service_enable = $munin::bool_disableboot ? {
    true    => false,
    default => $munin::bool_disable ? {
      true    => false,
      default => $munin::bool_absent ? {
        true  => false,
        false => true,
      },
    },
  }

  $manage_service_ensure = $munin::bool_disable ? {
    true    => 'stopped',
    default =>  $munin::bool_absent ? {
      true    => 'stopped',
      default => 'running',
    },
  }

  $manage_service_autorestart = $munin::bool_service_autorestart ? {
    true    => Service[munin-node],
    false   => undef,
  }

  $manage_file = $munin::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  if $munin::bool_absent == true
  or $munin::bool_disable == true
  or $munin::bool_disableboot == true {
    $manage_monitor = false
  } else {
    $manage_monitor = true
  }

  if $munin::bool_absent == true
  or $munin::bool_disable == true {
    $manage_firewall = false
  } else {
    $manage_firewall = true
  }

  $manage_audit = $munin::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $munin::bool_audit_only ? {
    true  => false,
    false => true,
  }

  $manage_file_source = $munin::source ? {
    ''        => undef,
    default   => $munin::source,
  }

  $manage_file_content = $munin::template ? {
    ''        => undef,
    default   => template($munin::template),
  }

  ### Munin specifics

  if $munin::bool_server_local == true 
  or $munin::server == "$::ipaddress" {
    include munin::server
  }

  if $munin::bool_extra_plugins == true {
    include munin::extra
  }

  if $munin::bool_autoconfigure {
    file { 'munin-autoconfigure':
      ensure  => $munin::manage_file,
      path    => '/etc/cron.daily/munin-autoconfigure',
      mode    => '0755',
      owner   => 'root',
      group   => 'root',
      require => Package['munin-node'],
      content => template('munin/munin-autoconfigure.erb'),
      replace => $munin::manage_file_replace,
      audit   => $munin::manage_audit,
    }
  } else {
    file { 'munin-autoconfigure':
      ensure  => 'absent',
      path    => '/etc/cron.daily/munin-autoconfigure',
    }
  }

  if $munin::autoconfigure == 'once' {
    exec { 'munin-autoconfigure':
      command     => '/usr/sbin/munin-node-configure --shell 2> /dev/null | /bin/sh',
      refreshonly => true,
      subscribe   => Package['munin-node'],
    }
  }

  if $munin::package_perlcidr != '' {
    package { 'perl-cidrmunin':
      ensure => $munin::manage_aux_package,
      name   => $munin::package_perlcidr,
    }
  }


  ### Managed resources
  package { 'munin-node':
    ensure => $munin::manage_package,
    name   => $munin::package,
  }

  service { 'munin-node':
    ensure     => $munin::manage_service_ensure,
    name       => $munin::service,
    enable     => $munin::manage_service_enable,
    hasstatus  => $munin::service_status,
    pattern    => $munin::process,
    require    => Package['munin-node'],
  }

  file { 'munin-node.conf':
    ensure  => $munin::manage_file,
    path    => $munin::config_file,
    mode    => $munin::config_file_mode,
    owner   => $munin::config_file_owner,
    group   => $munin::config_file_group,
    require => Package['munin-node'],
    notify  => $munin::manage_service_autorestart,
    source  => $munin::manage_file_source,
    content => $munin::manage_file_content,
    replace => $munin::manage_file_replace,
    audit   => $munin::manage_audit,
  }

  # The whole munin configuration directory can be recursively overriden
  if $munin::source_dir {
    file { 'munin.dir':
      ensure  => directory,
      path    => $munin::config_dir,
      require => Package['munin-node'],
      notify  => $munin::manage_service_autorestart,
      source  => $munin::source_dir,
      recurse => true,
      purge   => $munin::bool_source_dir_purge,
      replace => $munin::manage_file_replace,
      audit   => $munin::manage_audit,
    }
  }

  # Exported Resource for Server automatic configuration
  @@file { "${munin::include_dir}/${fqdn}.conf":
    ensure  => $munin::manage_file,
    path    => "${munin::include_dir}/${fqdn}.conf",
    mode    => $munin::config_file_mode,
    owner   => $munin::config_file_owner,
    group   => $munin::config_file_group,
    content => template($munin::template_host),
    tag     => "munin_host_${munin::magic_tag}",
  }


  ### Include custom class if $my_class is set
  if $munin::my_class {
    include $munin::my_class
  }


  ### Provide puppi data, if enabled ( puppi => true )
  if $munin::bool_puppi == true {
    $classvars=get_class_args()
    puppi::ze { 'munin':
      ensure    => $munin::manage_file,
      variables => $classvars,
      helper    => $munin::puppi_helper,
    }
  }


  ### Service monitoring, if enabled ( monitor => true )
  if $munin::bool_monitor == true {
    monitor::port { "munin_${munin::protocol}_${munin::port}":
      protocol => $munin::protocol,
      port     => $munin::port,
      target   => $munin::monitor_target,
      tool     => $munin::monitor_tool,
      enable   => $munin::manage_monitor,
    }
    monitor::process { 'munin_process':
      process  => $munin::process,
      service  => $munin::service,
      pidfile  => $munin::pid_file,
      user     => $munin::process_user,
      argument => $munin::process_args,
      tool     => $munin::monitor_tool,
      enable   => $munin::manage_monitor,
    }
  }


  ### Firewall management, if enabled ( firewall => true )
  if $munin::bool_firewall == true {
    firewall { "munin_${munin::protocol}_${munin::port}":
      source      => $munin::firewall_src,
      destination => $munin::firewall_dst,
      protocol    => $munin::protocol,
      port        => $munin::port,
      action      => 'allow',
      direction   => 'input',
      tool        => $munin::firewall_tool,
      enable      => $munin::manage_firewall,
    }
  }


  ### Debugging, if enabled ( debug => true )
  if $munin::bool_debug == true {
    file { 'debug_munin':
      ensure  => $munin::manage_file,
      path    => "${settings::vardir}/debug-munin",
      mode    => '0640',
      owner   => 'root',
      group   => 'root',
      content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
    }
  }

}
