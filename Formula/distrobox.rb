class Distrobox < Formula
  desc "Use any Linux distribution inside your terminal"
  homepage "https://distrobox.it"
  url "https://github.com/89luca89/distrobox/archive/refs/tags/1.8.2.3.tar.gz"
  sha256 "b4fcc60c0b856aac93385ea0eb88fb27fdaeb00b365c75e0eed497c306069837"
  license "GPL-3.0-only"
  head "https://github.com/89luca89/distrobox.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b5bd0c6a7fb91aed3b1b9a56c067737e1cd8cb45ed9520fc10f2f015e7d74b86"
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
