# sources: http://fullstack-puppet-docs.readthedocs.io/en/latest/puppet_modules.html

# === Class: jayeola-solr::install

# use this class to install what you need to...

class jayeola-solr::install inherits jayeola-solr {

  $my_common_packages = ['lsof', 'git', 'screen', 'wget', 'curl' ]

  $my_cx_packages = [ 'java-1.8.0-openjdk', 'epel-release', 'tomcat-changeme' ]

  $my_ux_packages = ['openjdk-7-jdk', 'solr-tomcat']

  case $::operatingsystem {
    'CentOS'::{ package {
      $my_common_packages: ensure => installed,
      $my_cx_packages: ensure => installed,
      }
    'Fedora':{ package {
      $my_common_packages: ensure => installed,
      $my_cx_packages: ensure => installed,
      }
     }
    'Redhat':{ package {
      $my_common_packages: ensure => installed,
      $my_cx_packages: ensure => installed,
      }
    'Ubuntu':{ package {
      $my_common_packages: ensure => installed,
      $my_ux_packages: ensure => installed,
      }
    'Debian':{ package {
      $my_common_packages: ensure => installed,
      $my_ux_packages: ensure => installed,
      }
  }

}

  #
  # file { '/tmp/solr-6.2.1-src.tgz':
  #   source =>  'puppet:///modules/jayeola-solr/solr-6.2.1-src.tgz',
  #   ensure => present,
  # }
  #
  # exec { 'tar -xvf /tmp/solr-6.2.1-src.tgz':
  #   cwd     => '/tmp',
  #   creates => '/tmp/solr-6.2.1',
  #   path    => ['/usr/bin', '/usr/sbin',],
  # }


  # file { '/root/install_solr_service.sh':
  #   source = 'puppet:///modules/jayeola-solr/install_solr_service.sh'
  #   ensure => file,
  #   mode => '0644',
  # }


# example usage:
#
# #Install prerequisites
# exec { "VPSMonPrerequisites":
#     command     => "yum install -y ${vpsmonitor::params::prerequisites}",
#     unless      => "rpm -qi ${vpsmonitor::params::prerequisites}",
#     timeout     => 3600,
# }
# #Install tgz from source url
# netinstall { vpsmonitor:
#     url                 => "${vpsmonitor::params::source_url}",
#     extracted_dir       => "${vpsmonitor::params::extracted_dir}",
#     destination_dir     => "${vpsmonitor::params::destination_dir}",
#     postextract_command => "chown -R user. ${vpsmonitor::params::destination_dir}/${vpsmonitor::params::extracted_dir}",
#     require             => [ Exec["VPSMonPrerequisites"], User["user"] ],
# }
#




# wtf did we do this time?



# $extracted_dir,
#   $destination_dir,
#   $owner = "root",
#   $group = "root",
#   $work_dir = "/var/tmp",
#   $extract_command = "tar -zxvf",
#   $preextract_command = "",
#   $postextract_command = ""
# ) {
#   $source_filename = urlfilename($url)
#
#   if $preextract_command {
#       exec {
#           "PreExtract $source_filename":
#               command => $preextract_command,
#               before  => Exec["Extract $source_filename"],
#               refreshonly => true,
#       }
#   }
#
#   exec {
#       "Retrieve $url":
#           cwd     => "$work_dir",
#           command => "wget $url",
#           creates => "$work_dir/$source_filename",
#           timeout => 3600,
#   }
#
#   exec {
#       "Extract $source_filename":
#           command => "mkdir -p $destination_dir && cd $destination_dir && $extract_command $work_dir/$source_filename",
#           unless  => "find $destination_dir | grep $extracted_dir",
#           creates => "${destination_dir}/${extracted_dir}",
#           require => Exec["Retrieve $url"],
#   }
#
#   if $postextract_command {
#       exec {
#           "PostExtract $source_filename":
#               command => $postextract_command,
#               cwd => "$destination_dir/$extracted_dir",
#               subscribe => Exec["Extract $source_filename"],
#               refreshonly => true,
#               timeout => 3600,
#               require => Exec["Retrieve $url"],
#       }
#   }
# }




# /Users/jayeola/projects/jayeola/puppet-vagrant/etc/puppet/modules/jayeola-solr/files/
# - **owner**
#     The user to whom the file should belong.  Argument can be a user name or
#     a
#     user ID.
#     On Windows, a group (such as "Administrators") can be set as a file's
#     owner
#     and a user (such as "Administrator") can be set as a file's group;
#     however,
#     a file's owner and group shouldn't be the same. (If the owner is also
#     the group, files with modes like `0640` will cause log churn, as they
#     will always appear out of sync.)
#
# - **path** (*namevar*)
#     The path to the file to manage.  Must be fully qualified.
#     On Windows, the path should include the drive letter and should use `/`
#     as
# the separator character (rather than `\\`).
#
# - **purge**
#     Whether unmanaged files should be purged. This option only makes
#     sense when `ensure => directory` and `recurse => true`.
#     * When recursively duplicating an entire directory with the `source`
#       attribute, `purge => true` will automatically purge any files
#       that are not in the source directory.
#     * When managing files in a directory as individual resources,
#       setting `purge => true` will purge any files that aren't being
#       specifically managed.
#     If you have a filebucket configured, the purged files will be uploaded,
#     but if you do not, this will destroy data.
#     Unless `force => true` is set, purging will **not** delete directories,
#     although it will delete the files they contain.
#     If `recurselimit` is set and you aren't using `force => true`, purging
#     will obey the recursion limit; files in any subdirectories deeper than
#     the
#     limit will be treated as unmanaged and left alone.
#     Valid values are `true`, `false`, `yes`, `no`.
#
# - **recurse**
#     Whether to recursively manage the _contents_ of a directory. This
#     attribute
#     is only used when `ensure => directory` is set. The allowed values are:
#     * `false` --- The default behavior. The contents of the directory will
#     not be
#       automatically managed.
#     * `remote` --- If the `source` attribute is set, Puppet will
#     automatically
#       manage the contents of the source directory (or directories), ensuring
#       that equivalent files and directories exist on the target system and
#       that their contents match.
#       Using `remote` will disable the `purge` attribute, but results in
#     faster
#       catalog application than `recurse => true`.
#       The `source` attribute is mandatory when `recurse => remote`.
#     * `true` --- If the `source` attribute is set, this behaves similarly to
#       `recurse => remote`, automatically managing files from the source
#     directory.
#       This also enables the `purge` attribute, which can delete unmanaged
#       files from a directory. See the description of `purge` for more
#     details.
#       The `source` attribute is not mandatory when using `recurse => true`,
#     so you
#       can enable purging in directories where all files are managed
#     individually.
#     By default, setting recurse to `remote` or `true` will manage _all_
#     subdirectories. You can use the `recurselimit` attribute to limit the
#     recursion depth.
# Valid values are `true`, `false`, `remote`.
#
# - **recurselimit**
#     How far Puppet should descend into subdirectories, when using
#     `ensure => directory` and either `recurse => true` or `recurse =>
#     remote`.
#     The recursion limit affects which files will be copied from the `source`
#     directory, as well as which files can be purged when `purge => true`.
#     Setting `recurselimit => 0` is the same as setting `recurse => false`
#     ---
#     Puppet will manage the directory, but all of its contents will be
#     treated
#     as unmanaged.
#     Setting `recurselimit => 1` will manage files and directories that are
#     directly inside the directory, but will not manage the contents of any
#     subdirectories.
#     Setting `recurselimit => 2` will manage the direct contents of the
#     directory, as well as the contents of the _first_ level of
#     subdirectories.
#     And so on --- 3 will manage the contents of the second level of
#     subdirectories, etc.
# Values can match `/^[0-9]+$/`.
#
# - **replace**
#     Whether to replace a file or symlink that already exists on the local
#     system but
#     whose content doesn't match what the `source` or `content` attribute
#     specifies.  Setting this to false allows file resources to initialize
#     files
#     without overwriting future changes.  Note that this only affects
#     content;
#     Puppet will still manage ownership and permissions. Defaults to `true`.
#     Valid values are `true`, `false`, `yes`, `no`.
#
# - **selinux_ignore_defaults**
#     If this is set then Puppet will not ask SELinux (via matchpathcon) to
#     supply defaults for the SELinux attributes (seluser, selrole,
#     seltype, and selrange). In general, you should leave this set at its
#     default and only set it to true when you need Puppet to not try to fix
#     SELinux labels automatically.
# Valid values are `true`, `false`.
#
# - **selrange**
#     What the SELinux range component of the context of the file should be.
#     Any valid SELinux range component is accepted.  For example `s0` or
#     `SystemHigh`.  If not specified it defaults to the value returned by
#     matchpathcon for the file, if any exists.  Only valid on systems with
#     SELinux support enabled and that have support for MCS (Multi-Category
#     Security).
#
# - **selrole**
#     What the SELinux role component of the context of the file should be.
#     Any valid SELinux role component is accepted.  For example `role_r`.
#     If not specified it defaults to the value returned by matchpathcon for
#     the file, if any exists.  Only valid on systems with SELinux support
#     enabled.
#
# - **seltype**
#     What the SELinux type component of the context of the file should be.
#     Any valid SELinux type component is accepted.  For example `tmp_t`.
#     If not specified it defaults to the value returned by matchpathcon for
#     the file, if any exists.  Only valid on systems with SELinux support
#     enabled.
#
# - **seluser**
#     What the SELinux user component of the context of the file should be.
#     Any valid SELinux user component is accepted.  For example `user_u`.
#     If not specified it defaults to the value returned by matchpathcon for
#     the file, if any exists.  Only valid on systems with SELinux support
#     enabled.
#
# - **show_diff**
#     Whether to display differences when the file changes, defaulting to
#     true.  This parameter is useful for files that may contain passwords or
#     other secret data, which might otherwise be included in Puppet reports
#     or
#     other insecure outputs.  If the global `show_diff` setting
#     is false, then no diffs will be shown even if this parameter is true.
#     Valid values are `true`, `false`, `yes`, `no`.
#
# - **source**
#     A source file, which will be copied into place on the local system. This
#     attribute is mutually exclusive with `content` and `target`. Allowed
#     values are:
#     * `puppet:` URIs, which point to files in modules or Puppet file server
#     mount points.
#     * Fully qualified paths to locally available files (including files on
#     NFS
#     shares or Windows mapped drives).
#     * `file:` URIs, which behave the same as local file paths.
#     * `http:` URIs, which point to files served by common web servers
#     The normal form of a `puppet:` URI is:
#     `puppet:///modules/<MODULE NAME>/<FILE PATH>`
#     This will fetch a file from a module on the Puppet master (or from a
#     local module when using Puppet apply). Given a `modulepath` of
#     `/etc/puppetlabs/code/modules`, the example above would resolve to
#     `/etc/puppetlabs/code/modules/<MODULE NAME>/files/<FILE PATH>`.
#     Unlike `content`, the `source` attribute can be used to recursively copy
#     directories if the `recurse` attribute is set to `true` or `remote`. If
#     a source directory contains symlinks, use the `links` attribute to
#     specify whether to recreate links or follow them.
#     *HTTP* URIs cannot be used to recursively synchronize whole directory
#     trees. It is also not possible to use `source_permissions` values other
#     than `ignore`. That's because HTTP servers do not transfer any metadata
#     that translates to ownership or permission details.
#     Multiple `source` values can be specified as an array, and Puppet will
#     use the first source that exists. This can be used to serve different
#     files to different system types:
#
#     Alternately, when serving directories recursively, multiple sources can
#     be combined by setting the `sourceselect` attribute to `all`.
#
# - **source_permissions**
#     Whether (and how) Puppet should copy owner, group, and mode permissions
#     from
#     the `source` to `file` resources when the permissions are not explicitly
#     specified. (In all cases, explicit permissions will take precedence.)
#     Valid values are `use`, `use_when_creating`, and `ignore`:
#     * `ignore` (the default) will never apply the owner, group, or mode from
#       the `source` when managing a file. When creating new files without
#     explicit
#       permissions, the permissions they receive will depend on
#     platform-specific
#       behavior. On POSIX, Puppet will use the umask of the user it is
#     running as.
#       On Windows, Puppet will use the default DACL associated with the user
#     it is
#       running as.
#     * `use` will cause Puppet to apply the owner, group,
#       and mode from the `source` to any files it is managing.
#     * `use_when_creating` will only apply the owner, group, and mode from
#     the
#       `source` when creating a file; existing files will not have their
#     permissions
#       overwritten.
# Valid values are `use`, `use_when_creating`, `ignore`.
#
# - **sourceselect**
#     Whether to copy all valid sources, or just the first one.  This
#     parameter
#     only affects recursive directory copies; by default, the first valid
#     source is the only one used, but if this parameter is set to `all`, then
#     all valid sources will have all of their contents copied to the local
#     system. If a given file exists in more than one source, the version from
#     the earliest source in the list will be used.
#     Valid values are `first`, `all`.
#
# - **target**
#     The target for creating a link.  Currently, symlinks are the
#     only type supported. This attribute is mutually exclusive with `source`
#     and `content`.
#     Symlink targets can be relative, as well as absolute:
#         # (Useful on Solaris)
#         file { '/etc/inetd.conf':
#           ensure => link,
#           target => 'inet/inetd.conf',
#         }
#     Directories of symlinks can be served recursively by instead using the
#     `source` attribute, setting `ensure` to `directory`, and setting the
#     `links` attribute to `manage`.
#     Valid values are `notlink`. Values can match `/./`.
#
# - **type**
#     A read-only state to check the file type.
#
# - **validate_cmd**
#     A command for validating the file's syntax before replacing it. If
#     Puppet would need to rewrite a file due to new `source` or `content`, it
#     will check the new content's validity first. If validation fails, the
#     file
#     resource will fail.
#     This command must have a fully qualified path, and should contain a
#     percent (`%`) token where it would expect an input file. It must exit
#     `0`
#     if the syntax is correct, and non-zero otherwise. The command will be
#     run on the target system while applying the catalog, not on the puppet
#     master.
#     Example:
#         file { '/etc/apache2/apache2.conf':
#           content      => 'example',
#           validate_cmd => '/usr/sbin/apache2 -t -f %',
#         }
#     This would replace apache2.conf only if the test returned true.
#     Note that if a validation command requires a `%` as part of its text,
#     you can specify a different placeholder token with the
#     `validate_replacement` attribute.
#
# - **validate_replacement**
#     The replacement string in a `validate_cmd` that will be replaced
#     with an input file name. Defaults to: `%`
#
# Providers
# ---------
#     posix, windows
# tw1-mbp :: ~ » puppet describe package
# WARN: Unresolved specs during Gem::Specification.reset:
#       hiera (< 4, >= 2.0)
#       json_pure (>= 0)
# WARN: Clearing out unresolved specs.
# Please report a bug if this causes problems.
#
# package
# =======
# Manage packages.  There is a basic dichotomy in package
# support right now:  Some package types (e.g., yum and apt) can
# retrieve their own package files, while others (e.g., rpm and sun)
# cannot.  For those package formats that cannot retrieve their own files,
# you can use the `source` parameter to point to the correct file.
# Puppet will automatically guess the packaging format that you are
# using based on the platform you are on, but you can override it
# using the `provider` parameter; each provider defines what it
# requires in order to function, and you must meet those requirements
# to use a given provider.
# You can declare multiple package resources with the same `name`, as long
# as they specify different providers and have unique titles.
# Note that you must use the _title_ to make a reference to a package
# resource; `Package[<NAME>]` is not a synonym for `Package[<TITLE>]` like
# it is for many other resource types.
# **Autorequires:** If Puppet is managing the files specified as a
# package's `adminfile`, `responsefile`, or `source`, the package
# resource will autorequire those files.
#
#
# Parameters
# ----------
#
# - **adminfile**
#     A file containing package defaults for installing packages.
#     This attribute is only used on Solaris. Its value should be a path to a
#     local file stored on the target system. Solaris's package tools expect
#     either an absolute file path or a relative path to a file in
#     `/var/sadm/install/admin`.
#     The value of `adminfile` will be passed directly to the `pkgadd` or
#     `pkgrm` command with the `-a <ADMINFILE>` option.
#
# - **allow_virtual**
#     Specifies if virtual package names are allowed for install and
#     uninstall.
#     Valid values are `true`, `false`, `yes`, `no`.
#     Requires features virtual_packages.
#
# - **allowcdrom**
#     Tells apt to allow cdrom sources in the sources.list file.
#     Normally apt will bail if you try this.
#     Valid values are `true`, `false`.
#
# - **category**
#     A read-only parameter set by the package.
#
# - **configfiles**
#     Whether to keep or replace modified config files when installing or
#     upgrading a package. This only affects the `apt` and `dpkg` providers.
#     Defaults to `keep`.
# Valid values are `keep`, `replace`.
#
# - **description**
#     A read-only parameter set by the package.
#
# - **ensure**
#     What state the package should be in. On packaging systems that can
#     retrieve new packages on their own, you can choose which package to
#     retrieve by specifying a version number or `latest` as the ensure
#     value. On packaging systems that manage configuration files separately
#     from "normal" system files, you can uninstall config files by
#     specifying `purged` as the ensure value. This defaults to `installed`.
#     Version numbers must match the full version to install, including
#     release if the provider uses a release moniker. Ranges or semver
#     patterns are not accepted except for the `gem` package provider. For
#     example, to install the bash package from the rpm
#     `bash-4.1.2-29.el6.x86_64.rpm`, use the string `'4.1.2-29.el6'`.
#     Valid values are `present` (also called `installed`), `absent`,
#     `purged`, `held`, `latest`. Values can match `/./`.
#
# - **flavor**
#     OpenBSD supports 'flavors', which are further specifications for
#     which type of package you want.
#
# - **install_options**
#     An array of additional options to pass when installing a package. These
#     options are package-specific, and should be documented by the software
#     vendor.  One commonly implemented option is `INSTALLDIR`:
#     package { 'mysql':
#           ensure          => installed,
#           source          => 'N:/packages/mysql-5.5.16-winx64.msi',
#           install_options => [ '/S', { 'INSTALLDIR' => 'C:\mysql-5.5' } ],
#         }
#
#     Each option in the array can either be a string or a hash, where each
#     key and value pair are interpreted in a provider specific way.  Each
#     option will automatically be quoted when passed to the install command.
#
#     With Windows packages, note that file paths in an install option must
#     use backslashes. (Since install options are passed directly to the
#     installation command, forward slashes won't be automatically converted
#     like they are in `file` resources.) Note also that backslashes in
#     double-quoted strings _must_ be escaped and backslashes in single-quoted
#     strings _can_ be escaped.
#
#
#
# Requires features install_options.
#
# - **instance**
#     A read-only parameter set by the package.
#
# - **name**
#     The package name.  This is the name that the packaging
#     system uses internally, which is sometimes (especially on Solaris)
#     a name that is basically useless to humans.  If a package goes by
#     several names, you can use a single title and then set the name
#     conditionally:
#     # In the 'openssl' class
#         $ssl = $operatingsystem ? {
#           solaris => SMCossl,
#           default => openssl
#         }
#     package { 'openssl':
#           ensure => installed,
#           name   => $ssl,
#         }
#     . etc. .
#     $ssh = $operatingsystem ? {
#           solaris => SMCossh,
#           default => openssh
#         }
#     package { 'openssh':
#           ensure  => installed,
#           name    => $ssh,
#       require => Package['openssl'],
#     }
#
#
# - **package_settings**
#     Settings that can change the contents or configuration of a package.
#     The formatting and effects of package_settings are provider-specific;
#     any
#     provider that implements them must explain how to use them in its
#     documentation. (Our general expectation is that if a package is
#     installed but its settings are out of sync, the provider should
#     re-install that package with the desired settings.)
#     An example of how package_settings could be used is FreeBSD's port build
#     options --- a future version of the provider could accept a hash of
#     options,
#     and would reinstall the port if the installed version lacked the correct
#     settings.
#         package { 'www/apache22':
#           package_settings => { 'SUEXEC' => false }
#         }
#     Again, check the documentation of your platform's package provider to
#     see
# the actual usage.
# Requires features package_settings.
#
# - **platform**
#     A read-only parameter set by the package.
#
# - **reinstall_on_refresh**
#     Whether this resource should respond to refresh events (via `subscribe`,
#     `notify`, or the `~>` arrow) by reinstalling the package. Only works for
#     providers that support the `reinstallable` feature.
#     This is useful for source-based distributions, where you may want to
#     recompile a package if the build options change.
#     If you use this, be careful of notifying classes when you want to
#     restart
#     services. If the class also contains a refreshable package, doing so
#     could
#     cause unnecessary re-installs.
#     Defaults to `false`.
# Valid values are `true`, `false`.
#
# - **responsefile**
#     A file containing any necessary answers to questions asked by
#     the package.  This is currently used on Solaris and Debian.  The
#     value will be validated according to system rules, but it should
#     generally be a fully qualified path.
#
# - **root**
#     A read-only parameter set by the package.
#
# - **source**
#     Where to find the package file. This is only used by providers that
#     don't
#     automatically download packages from a central repository. (For example:
#     the `yum` and `apt` providers ignore this attribute, but the `rpm` and
#     `dpkg` providers require it.)
#     Different providers accept different values for `source`. Most providers
#     accept paths to local files stored on the target system. Some providers
#     may also accept URLs or network drive paths. Puppet will not
#     automatically retrieve source files for you, and usually just passes the
#     value of `source` to the package installation command.
#     You can use a `file` resource if you need to manually copy package files
#     to the target system.
#
# - **status**
#     A read-only parameter set by the package.
#
# - **uninstall_options**
#     An array of additional options to pass when uninstalling a package.
#     These
#     options are package-specific, and should be documented by the software
#     vendor.  For example:
#     package { 'VMware Tools':
#           ensure            => absent,
#           uninstall_options => [ { 'REMOVE' => 'Sync,VSS' } ],
#         }
#
#     Each option in the array can either be a string or a hash, where each
#     key and value pair are interpreted in a provider specific way.  Each
#     option will automatically be quoted when passed to the uninstall
#     command.
#
#     On Windows, this is the **only** place in Puppet where backslash
#     separators should be used.  Note that backslashes in double-quoted
#     strings _must_ be double-escaped and backslashes in single-quoted
#     strings _may_ be double-escaped.
#
#
#
# Requires features uninstall_options.
#
# - **vendor**
#     A read-only parameter set by the package.
#
# Providers
# ---------
#     aix, appdmg, apple, apt, aptitude, aptrpm, blastwave, dnf, dpkg, fink,
#     freebsd, gem, hpux, macports, nim, openbsd, opkg, pacman, pip, pip3,
#     pkg, pkgdmg, pkgin, pkgng, pkgutil, portage, ports, portupgrade,
#     puppet_gem, rpm, rug, sun, sunfreeware, up2date, urpmi, windows, yum,
#     zypper
# tw1-mbp :: ~ » puppet describe file
# WARN: Unresolved specs during Gem::Specification.reset:
#       hiera (< 4, >= 2.0)
#       json_pure (>= 0)
# WARN: Clearing out unresolved specs.
# Please report a bug if this causes problems.
#
# file
# ====
# Manages files, including their content, ownership, and permissions.
# The `file` type can manage normal files, directories, and symlinks; the
# type should be specified in the `ensure` attribute.
# File contents can be managed directly with the `content` attribute, or
# downloaded from a remote source using the `source` attribute; the latter
# can also be used to recursively serve directories (when the `recurse`
# attribute is set to `true` or `local`). On Windows, note that file
# contents are managed in binary mode; Puppet never automatically translates
# line endings.
# **Autorequires:** If Puppet is managing the user or group that owns a
# file, the file resource will autorequire them. If Puppet is managing any
# parent directories of a file, the file resource will autorequire them.
#
#
# Parameters
# ----------
#
# - **backup**
#     Whether (and how) file content should be backed up before being
#     replaced.
#     This attribute works best as a resource default in the site manifest
#     (`File { backup => main }`), so it can affect all file resources.
#     * If set to `false`, file content won't be backed up.
#     * If set to a string beginning with `.` (e.g., `.puppet-bak`), Puppet
#     will
#       use copy the file in the same directory with that value as the
#     extension
#       of the backup. (A value of `true` is a synonym for `.puppet-bak`.)
#     * If set to any other string, Puppet will try to back up to a filebucket
#       with that title. See the `filebucket` resource type for more details.
#       (This is the preferred method for backup, since it can be centralized
#       and queried.)
#     Default value: `puppet`, which backs up to a filebucket of the same
#     name.
#     (Puppet automatically creates a **local** filebucket named `puppet` if
#     one
#     doesn't already exist.)
#     Backing up to a local filebucket isn't particularly useful. If you want
#     to make organized use of backups, you will generally want to use the
#     puppet master server's filebucket service. This requires declaring a
#     filebucket resource and a resource default for the `backup` attribute
#     in site.pp:
#         # /etc/puppetlabs/puppet/manifests/site.pp
#         filebucket { 'main':
#           path   => false,                # This is required for remote
#     filebuckets.
#           server => 'puppet.example.com', # Optional; defaults to the
#     configured puppet master.
#         }
#         File { backup => main, }
#     If you are using multiple puppet master servers, you will want to
#     centralize the contents of the filebucket. Either configure your load
#     balancer to direct all filebucket traffic to a single master, or use
#     something like an out-of-band rsync task to synchronize the content on
#     all
# masters.
#
# - **checksum**
#     The checksum type to use when determining whether to replace a file's
#     contents.
#     The default checksum type is md5.
#     Valid values are `md5`, `md5lite`, `sha256`, `sha256lite`, `mtime`,
#     `ctime`, `none`.
#
# - **checksum_value**
#     The checksum of the source contents. Only md5 and sha256 are supported
#     when
#     specifying this parameter. If this parameter is set, source_permissions
#     will be
#     assumed to be false, and ownership and permissions will not be read from
#     source.
#
# - **content**
#     The desired contents of a file, as a string. This attribute is mutually
#     exclusive with `source` and `target`.
#     Newlines and tabs can be specified in double-quoted strings using
#     standard escaped syntax --- \n for a newline, and \t for a tab.
#     With very small files, you can construct content strings directly in
#     the manifest...
#         define resolve(nameserver1, nameserver2, domain, search) {
#             $str = "search ${search}
#                 domain ${domain}
#                 nameserver ${nameserver1}
#                 nameserver ${nameserver2}
#                 "
#             file { '/etc/resolv.conf':
#               content => $str,
#             }
#         }
#     ...but for larger files, this attribute is more useful when combined
#     with the
#     or
#     or
#     or
#     or
#     or
#     s://docs.puppetlabs.com/puppet/latest/reference/function.html#template)
#     or
#     function.
#     ps://docs.puppetlabs.com/puppet/latest/reference/function.html#file)
#     function.
#
# - **ctime**
#     A read-only state to check the file ctime. On most modern \*nix-like
#     systems, this is the time of the most recent change to the owner, group,
#     permissions, or content of the file.
#
# - **ensure**
#     Whether the file should exist, and if so what kind of file it should be.
#     Possible values are `present`, `absent`, `file`, `directory`, and
#     `link`.
#     * `present` accepts any form of file existence, and creates a
#       normal file if the file is missing. (The file will have no content
#       unless the `content` or `source` attribute is used.)
#     * `absent` ensures the file doesn't exist, and deletes it if necessary.
#     * `file` ensures it's a normal file, and enables use of the `content` or
#       `source` attribute.
#     * `directory` ensures it's a directory, and enables use of the `source`,
#       `recurse`, `recurselimit`, `ignore`, and `purge` attributes.
#     * `link` ensures the file is a symlink, and **requires** that you also
#       set the `target` attribute. Symlinks are supported on all Posix
#       systems and on Windows Vista / 2008 and higher. On Windows, managing
#       symlinks requires Puppet agent's user account to have the "Create
#       Symbolic Links" privilege; this can be configured in the "User Rights
#       Assignment" section in the Windows policy editor. By default, Puppet
#       agent runs as the Administrator account, which has this privilege.
#     Puppet avoids destroying directories unless the `force` attribute is set
#     to `true`. This means that if a file is currently a directory, setting
#     `ensure` to anything but `directory` or `present` will cause Puppet to
#     skip managing the resource and log either a notice or an error.
#     There is one other non-standard value for `ensure`. If you specify the
#     path to another file as the ensure value, it is equivalent to specifying
#     `link` and using that path as the `target`:
#         # Equivalent resources:
#         file { '/etc/inetd.conf':
#           ensure => '/etc/inet/inetd.conf',
#         }
#         file { '/etc/inetd.conf':
#           ensure => link,
#           target => '/etc/inet/inetd.conf',
#         }
#     However, we recommend using `link` and `target` explicitly, since this
#     behavior can be harder to read and is
#     as of Puppet 4.3.0.
#     /docs.puppetlabs.com/puppet/4.3/reference/deprecated_language.html)
#     as of Puppet 4.3.0.
#     Valid values are `absent` (also called `false`), `file`, `present`,
#     `directory`, `link`. Values can match `/./`.
#
# - **force**
#     Perform the file operation even if it will destroy one or more
#     directories.
#     You must use `force` in order to:
#     * `purge` subdirectories
#     * Replace directories with files or links
#     * Remove a directory when `ensure => absent`
#     Valid values are `true`, `false`, `yes`, `no`.
#
# - **group**
#     Which group should own the file.  Argument can be either a group
#     name or a group ID.
#     On Windows, a user (such as "Administrator") can be set as a file's
#     group
#     and a group (such as "Administrators") can be set as a file's owner;
#     however, a file's owner and group shouldn't be the same. (If the owner
#     is also the group, files with modes like `0640` will cause log churn, as
#     they will always appear out of sync.)
#
# - **ignore**
#     A parameter which omits action on files matching
#     specified patterns during recursion.  Uses Ruby's builtin globbing
#     engine, so shell metacharacters are fully supported, e.g. `[a-z]*`.
#     Matches that would descend into the directory structure are ignored,
#     e.g., `*/*`.
#
# - **links**
#     How to handle links during file actions.  During file copying,
#     `follow` will copy the target file instead of the link and `manage`
#     will copy the link itself. When not copying, `manage` will manage
#     the link, and `follow` will manage the file to which the link points.
#     Valid values are `follow`, `manage`.
#
# - **mode**
#     The desired permissions mode for the file, in symbolic or numeric
#     notation. This value **must** be specified as a string; do not use
#     un-quoted numbers to represent file modes.
#     The `file` type uses traditional Unix permission schemes and translates
#     them to equivalent permissions for systems which represent permissions
#     differently, including Windows. For detailed ACL controls on Windows,
#     you can leave `mode` unmanaged and use
#     [the puppetlabs/acl
#     module.](https://forge.puppetlabs.com/puppetlabs/acl)
#     Numeric modes should use the standard octal notation of
#     `<SETUID/SETGID/STICKY><OWNER><GROUP><OTHER>` (e.g. '0644').
#     * Each of the "owner," "group," and "other" digits should be a sum of
#     the
#       permissions for that class of users, where read = 4, write = 2, and
#       execute/search = 1.
#     * The setuid/setgid/sticky digit is also a sum, where setuid = 4, setgid
#     = 2,
#       and sticky = 1.
#     * The setuid/setgid/sticky digit is optional. If it is absent, Puppet
#     will
#       clear any existing setuid/setgid/sticky permissions. (So to make your
#     intent
#       clear, you should use at least four digits for numeric modes.)
#     * When specifying numeric permissions for directories, Puppet sets the
#     search
#       permission wherever the read permission is set.
#     Symbolic modes should be represented as a string of comma-separated
#     permission clauses, in the form `<WHO><OP><PERM>`:
#     * "Who" should be u (user), g (group), o (other), and/or a (all)
#     * "Op" should be = (set exact permissions), + (add select permissions),
#       or - (remove select permissions)
#     * "Perm" should be one or more of:
#         * r (read)
#         * w (write)
#         * x (execute/search)
#         * t (sticky)
#         * s (setuid/setgid)
#         * X (execute/search if directory or if any one user can execute)
#         * u (user's current permissions)
#         * g (group's current permissions)
#         * o (other's current permissions)
#     Thus, mode `0664` could be represented symbolically as either `a=r,ug+w`
#     or `ug=rw,o=r`.  However, symbolic modes are more expressive than
#     numeric
#     modes: a mode only affects the specified bits, so `mode => 'ug+w'` will
#     set the user and group write bits, without affecting any other bits.
#     See the manual page for GNU or BSD `chmod` for more details
#     on numeric and symbolic modes.
#     On Windows, permissions are translated as follows:
#     * Owner and group names are mapped to Windows SIDs
#     * The "other" class of users maps to the "Everyone" SID
#     * The read/write/execute permissions map to the `FILE_GENERIC_READ`,
#       `FILE_GENERIC_WRITE`, and `FILE_GENERIC_EXECUTE` access rights; a
#       file's owner always has the `FULL_CONTROL` right
#     * "Other" users can't have any permissions a file's group lacks,
#       and its group can't have any permissions its owner lacks; that is,
#     0644
#   is an acceptable mode, but 0464 is not.
#
# - **mtime**
#     A read-only state to check the file mtime. On \*nix-like systems, this
#     is the time of the most recent change to the content of the file.
#
# - **owner**
#     The user to whom the file should belong.  Argument can be a user name or
#     a
#     user ID.
#     On Windows, a group (such as "Administrators") can be set as a file's
#     owner
#     and a user (such as "Administrator") can be set as a file's group;
#     however,
#     a file's owner and group shouldn't be the same. (If the owner is also
#     the group, files with modes like `0640` will cause log churn, as they
#     will always appear out of sync.)
#
# - **path** (*namevar*)
#     The path to the file to manage.  Must be fully qualified.
#     On Windows, the path should include the drive letter and should use `/`
#     as
# the separator character (rather than `\\`).
#
# - **purge**
#     Whether unmanaged files should be purged. This option only makes
#     sense when `ensure => directory` and `recurse => true`.
#     * When recursively duplicating an entire directory with the `source`
#       attribute, `purge => true` will automatically purge any files
#       that are not in the source directory.
#     * When managing files in a directory as individual resources,
#       setting `purge => true` will purge any files that aren't being
#       specifically managed.
#     If you have a filebucket configured, the purged files will be uploaded,
#     but if you do not, this will destroy data.
#     Unless `force => true` is set, purging will **not** delete directories,
#     although it will delete the files they contain.
#     If `recurselimit` is set and you aren't using `force => true`, purging
#     will obey the recursion limit; files in any subdirectories deeper than
#     the
#     limit will be treated as unmanaged and left alone.
#     Valid values are `true`, `false`, `yes`, `no`.
#
# - **recurse**
#     Whether to recursively manage the _contents_ of a directory. This
#     attribute
#     is only used when `ensure => directory` is set. The allowed values are:
#     * `false` --- The default behavior. The contents of the directory will
#     not be
#       automatically managed.
#     * `remote` --- If the `source` attribute is set, Puppet will
#     automatically
#       manage the contents of the source directory (or directories), ensuring
#       that equivalent files and directories exist on the target system and
#       that their contents match.
#       Using `remote` will disable the `purge` attribute, but results in
#     faster
#       catalog application than `recurse => true`.
#       The `source` attribute is mandatory when `recurse => remote`.
#     * `true` --- If the `source` attribute is set, this behaves similarly to
#       `recurse => remote`, automatically managing files from the source
#     directory.
#       This also enables the `purge` attribute, which can delete unmanaged
#       files from a directory. See the description of `purge` for more
#     details.
#       The `source` attribute is not mandatory when using `recurse => true`,
#     so you
#       can enable purging in directories where all files are managed
#     individually.
#     By default, setting recurse to `remote` or `true` will manage _all_
#     subdirectories. You can use the `recurselimit` attribute to limit the
#     recursion depth.
# Valid values are `true`, `false`, `remote`.
#
# - **recurselimit**
#     How far Puppet should descend into subdirectories, when using
#     `ensure => directory` and either `recurse => true` or `recurse =>
#     remote`.
#     The recursion limit affects which files will be copied from the `source`
#     directory, as well as which files can be purged when `purge => true`.
#     Setting `recurselimit => 0` is the same as setting `recurse => false`
#     ---
#     Puppet will manage the directory, but all of its contents will be
#     treated
#     as unmanaged.
#     Setting `recurselimit => 1` will manage files and directories that are
#     directly inside the directory, but will not manage the contents of any
#     subdirectories.
#     Setting `recurselimit => 2` will manage the direct contents of the
#     directory, as well as the contents of the _first_ level of
#     subdirectories.
#     And so on --- 3 will manage the contents of the second level of
#     subdirectories, etc.
# Values can match `/^[0-9]+$/`.
#
# - **replace**
#     Whether to replace a file or symlink that already exists on the local
#     system but
#     whose content doesn't match what the `source` or `content` attribute
#     specifies.  Setting this to false allows file resources to initialize
#     files
#     without overwriting future changes.  Note that this only affects
#     content;
#     Puppet will still manage ownership and permissions. Defaults to `true`.
#     Valid values are `true`, `false`, `yes`, `no`.
#
# - **selinux_ignore_defaults**
#     If this is set then Puppet will not ask SELinux (via matchpathcon) to
#     supply defaults for the SELinux attributes (seluser, selrole,
#     seltype, and selrange). In general, you should leave this set at its
#     default and only set it to true when you need Puppet to not try to fix
#     SELinux labels automatically.
# Valid values are `true`, `false`.
#
# - **selrange**
#     What the SELinux range component of the context of the file should be.
#     Any valid SELinux range component is accepted.  For example `s0` or
#     `SystemHigh`.  If not specified it defaults to the value returned by
#     matchpathcon for the file, if any exists.  Only valid on systems with
#     SELinux support enabled and that have support for MCS (Multi-Category
#     Security).
#
# - **selrole**
#     What the SELinux role component of the context of the file should be.
#     Any valid SELinux role component is accepted.  For example `role_r`.
#     If not specified it defaults to the value returned by matchpathcon for
#     the file, if any exists.  Only valid on systems with SELinux support
#     enabled.
#
# - **seltype**
#     What the SELinux type component of the context of the file should be.
#     Any valid SELinux type component is accepted.  For example `tmp_t`.
#     If not specified it defaults to the value returned by matchpathcon for
#     the file, if any exists.  Only valid on systems with SELinux support
#     enabled.
#
# - **seluser**
#     What the SELinux user component of the context of the file should be.
#     Any valid SELinux user component is accepted.  For example `user_u`.
#     If not specified it defaults to the value returned by matchpathcon for
#     the file, if any exists.  Only valid on systems with SELinux support
#     enabled.
#
# - **show_diff**
#     Whether to display differences when the file changes, defaulting to
#     true.  This parameter is useful for files that may contain passwords or
#     other secret data, which might otherwise be included in Puppet reports
#     or
#     other insecure outputs.  If the global `show_diff` setting
#     is false, then no diffs will be shown even if this parameter is true.
#     Valid values are `true`, `false`, `yes`, `no`.
#
# - **source**
#     A source file, which will be copied into place on the local system. This
#     attribute is mutually exclusive with `content` and `target`. Allowed
#     values are:
#     * `puppet:` URIs, which point to files in modules or Puppet file server
#     mount points.
#     * Fully qualified paths to locally available files (including files on
#     NFS
#     shares or Windows mapped drives).
#     * `file:` URIs, which behave the same as local file paths.
#     * `http:` URIs, which point to files served by common web servers
#     The normal form of a `puppet:` URI is:
#     `puppet:///modules/<MODULE NAME>/<FILE PATH>`
#     This will fetch a file from a module on the Puppet master (or from a
#     local module when using Puppet apply). Given a `modulepath` of
#     `/etc/puppetlabs/code/modules`, the example above would resolve to
#     `/etc/puppetlabs/code/modules/<MODULE NAME>/files/<FILE PATH>`.
#     Unlike `content`, the `source` attribute can be used to recursively copy
#     directories if the `recurse` attribute is set to `true` or `remote`. If
#     a source directory contains symlinks, use the `links` attribute to
#     specify whether to recreate links or follow them.
#     *HTTP* URIs cannot be used to recursively synchronize whole directory
#     trees. It is also not possible to use `source_permissions` values other
#     than `ignore`. That's because HTTP servers do not transfer any metadata
#     that translates to ownership or permission details.
#     Multiple `source` values can be specified as an array, and Puppet will
#     use the first source that exists. This can be used to serve different
#     files to different system types:
#         file { '/etc/nfs.conf':
#           source => [
#             "puppet:///modules/nfs/conf.${host}",
#             "puppet:///modules/nfs/conf.${operatingsystem}",
#             'puppet:///modules/nfs/conf'
#           ]
#         }
#     Alternately, when serving directories recursively, multiple sources can
#     be combined by setting the `sourceselect` attribute to `all`.
#
# - **source_permissions**
#     Whether (and how) Puppet should copy owner, group, and mode permissions
#     from
#     the `source` to `file` resources when the permissions are not explicitly
#     specified. (In all cases, explicit permissions will take precedence.)
#     Valid values are `use`, `use_when_creating`, and `ignore`:
#     * `ignore` (the default) will never apply the owner, group, or mode from
#       the `source` when managing a file. When creating new files without
#     explicit
#       permissions, the permissions they receive will depend on
#     platform-specific
#       behavior. On POSIX, Puppet will use the umask of the user it is
#     running as.
#       On Windows, Puppet will use the default DACL associated with the user
#     it is
#       running as.
#     * `use` will cause Puppet to apply the owner, group,
#       and mode from the `source` to any files it is managing.
#     * `use_when_creating` will only apply the owner, group, and mode from
#     the
#       `source` when creating a file; existing files will not have their
#     permissions
#       overwritten.
# Valid values are `use`, `use_when_creating`, `ignore`.
#
# - **sourceselect**
#     Whether to copy all valid sources, or just the first one.  This
#     parameter
#     only affects recursive directory copies; by default, the first valid
#     source is the only one used, but if this parameter is set to `all`, then
#     all valid sources will have all of their contents copied to the local
#     system. If a given file exists in more than one source, the version from
#     the earliest source in the list will be used.
#     Valid values are `first`, `all`.
#
# - **target**
#     The target for creating a link.  Currently, symlinks are the
#     only type supported. This attribute is mutually exclusive with `source`
#     and `content`.
#     Symlink targets can be relative, as well as absolute:
#         # (Useful on Solaris)
#         file { '/etc/inetd.conf':
#           ensure => link,
#           target => 'inet/inetd.conf',
#         }
#     Directories of symlinks can be served recursively by instead using the
#     `source` attribute, setting `ensure` to `directory`, and setting the
#     `links` attribute to `manage`.
#     Valid values are `notlink`. Values can match `/./`.
#
# - **type**
#     A read-only state to check the file type.
#
# - **validate_cmd**
#     A command for validating the file's syntax before replacing it. If
#     Puppet would need to rewrite a file due to new `source` or `content`, it
#     will check the new content's validity first. If validation fails, the
#     file
#     resource will fail.
#     This command must have a fully qualified path, and should contain a
#     percent (`%`) token where it would expect an input file. It must exit
#     `0`
#     if the syntax is correct, and non-zero otherwise. The command will be
#     run on the target system while applying the catalog, not on the puppet
#     master.
#     Example:
#         file { '/etc/apache2/apache2.conf':
#           content      => 'example',
#           validate_cmd => '/usr/sbin/apache2 -t -f %',
#         }
#     This would replace apache2.conf only if the test returned true.
#     Note that if a validation command requires a `%` as part of its text,
#     you can specify a different placeholder token with the
#     `validate_replacement` attribute.
#
# - **validate_replacement**
#     The replacement string in a `validate_cmd` that will be replaced
#     with an input file name. Defaults to: `%`
#
# Providers
# ---------
#     posix, windows
# tw1-mbp :: ~ »
