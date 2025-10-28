class Distrobox < Formula
  desc "Use any Linux distribution inside your terminal"
  homepage "https://distrobox.it"
  url "https://github.com/89luca89/distrobox/archive/refs/tags/1.8.2.0.tar.gz"
  sha256 "c0afc3bac212840ffe3bdb335d0659e0976b0b566a993755f6846e444b9fa40a"
  license "GPL-3.0-only"
  head "https://github.com/89luca89/distrobox.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "659795966fcaa528f6826c43c42756a0b875961792e9b9572d9c240a4cf8876f"
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
