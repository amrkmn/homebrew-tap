class Distrobox < Formula
  desc "Use any Linux distribution inside your terminal"
  homepage "https://distrobox.it"
  url "https://github.com/89luca89/distrobox/archive/refs/tags/1.8.2.2.tar.gz"
  sha256 "0c797689c0b8c7c7c9fa53d1f5550657af95e64d8b8bbdc0fe374f341ebf6cd0"
  license "GPL-3.0-only"
  head "https://github.com/89luca89/distrobox.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ce649d08be9b0d89271aef4fbed61017ddfbc680cfe202bfcfebcda4474baea5"
  end

  depends_on :linux

  def install
    system "./install", "--prefix", prefix
  end

  def caveats
    <<~EOS
      Distrobox requires one of podman or docker. Do
        brew install podman
      or consult the documentation for details.
    EOS
  end

  test do
    system bin/"distrobox-create", "--dry-run"
  end
end
