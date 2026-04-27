class Distrobox < Formula
  desc "Use any Linux distribution inside your terminal"
  homepage "https://distrobox.it"
  url "https://github.com/89luca89/distrobox/archive/refs/tags/1.8.2.5.tar.gz"
  sha256 "0c3bc4785ee3be3b89f93abb7cc0a9f60e56989e81319af140a4b60403b18f80"
  license "GPL-3.0-only"
  head "https://github.com/89luca89/distrobox.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f96d999a733dbe9f823625d7cc5fc5461df09c6f4b5b1275d43294d526674ed1"
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
