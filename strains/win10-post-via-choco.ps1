## Chocolatey Post Instal Packsges
$packages = @(
  firefox tor deluge openvpn atom cygwin github_desktop
  punto_switcher peazip vlc aimp gimp steam java
)

foreach ($package in $packages) {
  choko install $package
}
