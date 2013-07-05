# Define: munin::plugin
#
# Adds or configures a Munin plugin.
# This define manages the script at $path (either using $source, $content, or the pre-existing file),
# the configuration at $config_path (using either $config_source or $config_content).
# The munin-node is notified of any change, unless disabled on the munin class.
#
# [*ensure*]
#   Specify whether this plugin should be present or absent. Default: present
#
# [*path*]
#   Specify the actual location of the plugin script. Default: "${munin::plugins_dir}/${name}"
#
# [*source*]
#   Specify the source of the plugin script. Default: empty
#
# [*content*]
#   Specify the actual text of the plugin script. Default: empty
#
# [*target*]
#   Specify the that the plugin should be symlinked to this. Default: $path
#
# [*config_path*]
#   Specify the actual location of the plugin's configuration. Default: "${munin::conf_dir_plugins}/${name}"
#
# [*config_source*]
#   Specify the source of the plugin's configuration. Default: empty
#
# [*config_content*]
#   Specify the actual text of the plugin's configuration. Default: empty
#
# Usage:
# Configure a non-auto, pre-installed plugin with no config:
# munin::plugin { 'apt':; }
#
# Configure a non-auto, pre-installed plugin with no config, and a $0 argument:
# munin::plugin { 'ping_192.168.0.1':
#   path => "${munin::plugins_dir}/ping_";
# }
#
# Define the configuration file of an existing plugin:
# munin::plugin { 'squid':
#   config_source => 'puppet:///modules/example42/munin/squid-config',
# }
#
# Define the configuration file of an existing plugin in-line:
# munin::plugin { 'nginx':
#   config_content => "[nginx*]\nenv.url http://localhost/nginx_status\n";
# }
#
# Provide a custom plugin:
# munin::plugin { 'redis':
#   source => 'puppet:///modules/example42/munin/redis',
# }
#
# Provide a custom plugin with a custom configuration:
# munin::plugin { 'redis':
#   source        => 'puppet:///modules/example42/munin/redis',
#   config_source => 'puppet:///modules/example42/munin/redis-conf',
# }
#
# Force a plugin to be inactive
# munin::plugin { 'foobar':
#   ensure => absent;
# }
#
define munin::plugin (
  $ensure         = 'present',
  $path           = '',
  $source         = '',
  $content        = '',
  $target         = '',
  $config_path    = '',
  $config_source  = '',
  $config_content = '',) {
  $real_path = $path ? {
    ''      => "${munin::plugins_dir}/${name}",
    default => $path,
  }

  $real_target = $target ? {
    ''      => $real_path,
    default => $target,
  }

  $real_config_path = $config_path ? {
    ''      => "${munin::conf_dir_plugins}/${name}",
    default => $path,
  }

  file { "Munin_plugin_${name}":
    ensure  => $ensure,
    path    => $real_path,
    mode    => '0755',
    owner   => $munin::config_file_owner,
    group   => $munin::config_file_group,
    require => Package['munin-node'],
    notify  => $munin::manage_service_autorestart,
  }

  if $source != '' {
    File["Munin_plugin_${name}"] {
      source => $source, }
  }

  if $content != '' {
    File["Munin_plugin_${name}"] {
      content => $content, }
  }

  file { "${munin::conf_dir_active_plugins}/${name}":
    ensure => $ensure ? {
      'present' => 'link',
      default   => 'absent',
    },
    target => $real_target,
  }

  file { "Munin_plugin_conf_${name}":
    ensure  => $ensure,
    path    => $real_config_path,
    mode    => '0644',
    owner   => $munin::config_file_owner,
    group   => $munin::config_file_group,
    require => Package['munin-node'],
    notify  => $munin::manage_service_autorestart,
  }

  if $config_source != '' {
    File["Munin_plugin_conf_${name}"] {
      source => $config_source, }
  }

  if $config_content != '' {
    File["Munin_plugin_conf_${name}"] {
      content => $config_content, }
  }
}
