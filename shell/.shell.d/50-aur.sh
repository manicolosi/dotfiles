function aur-get() {
  local base_url="https://aur.archlinux.org/packages"
  local package="${1}"
  local dir="${package:0:2}"

  echo "Downloading..."
  curl --silent --location --remote-name \
    "${base_url}/${dir}/${package}/${package}.tar.gz"
  echo "Unpackaging..."
  tar xf "${package}.tar.gz"
}

function aur-build() {
  local package="${1}"

  pushd "${package}"

  echo "Building..."
  makepkg -s

  popd

  echo "Install with \"pacman -U ${package}/${package}-*.pkg.tar.xz\""
}
