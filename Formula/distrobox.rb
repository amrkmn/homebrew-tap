class Distrobox < Formula
  desc "Use any Linux distribution inside your terminal"
  homepage "https://distrobox.it"
  url "https://github.com/89luca89/distrobox/archive/refs/tags/1.8.2.6.tar.gz"
  sha256 "693c85f44720f9c2be8691141eaa1dc2773ee37e63ae02fff8b838dcf54c413e"
  license "GPL-3.0-only"
  head "https://github.com/89luca89/distrobox.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    manifest_sha256 "d5d5ba7429ddaf1615c2d39088534afb92fe5e8f09a02dc75947ba597dcaa48d"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "1a3c35fe165b1dd453d4a9527b9863cb1544c7864812c05a27f6fc8e558bec6f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5cf8c619d399d320efc6329d6b80d3ef99899bce43db03f75ce918493dc2a587"
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
