class svn
{
  $packages = [
    "subversion"
  ]

  # This upgrades SVN to version 1.7 to match the version on most Macs.
  # http://ubuntuforums.org/showthread.php?t=1876156
  exec
  {
    "add-svn-repository":
    command => "echo 'deb http://opensource.wandisco.com/ubuntu lucid svn17' | sudo tee /etc/apt/sources.list.d/svn.list \
                && sudo wget -q http://opensource.wandisco.com/wandisco-debian.gpg -O- | sudo apt-key add - \
                && sudo apt-get update"
  }

  package
  {
    $packages:
    ensure => latest,
    require => Exec['add-svn-repository']
  }


}