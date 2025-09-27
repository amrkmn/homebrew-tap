class YtDlp < Formula
  include Language::Python::Virtualenv

  desc "Feature-rich command-line audio/video downloader"
  homepage "https://github.com/yt-dlp/yt-dlp"
  url "https://files.pythonhosted.org/packages/58/8f/0daea0feec1ab85e7df85b98ec7cc8c85d706362e80efc5375c7007dc3dc/yt_dlp-2025.9.26.tar.gz"
  sha256 "c148ae8233ac4ce6c5fbf6f70fcc390f13a00f59da3776d373cf88c5370bda86"
  license "Unlicense"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "fe8aa33f768843c50c2820238dfb5c65515e32751f27b2d96a759fd8cecc0b75"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ad9b2c268b9134bfc5cb4d2e5d10ac3cc9a6ff8d518217258d7e5d2fefededb2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "50b3b11abb45095246a9d716fb055171c13c08c9b5551a95fa03379c87be61df"
  end

  head do
    url "https://github.com/yt-dlp/yt-dlp.git", branch: "master"

    depends_on "pandoc" => :build

    on_macos do
      depends_on "make" => :build
    end
  end

  depends_on "certifi"
  depends_on "python@3.13"

  def install
    system "gmake", "lazy-extractors", "pypi-files" if build.head?
    virtualenv_install_with_resources
    bash_completion.install libexec/"share/bash-completion/completions/yt-dlp"
    zsh_completion.install libexec/"share/zsh/site-functions/_yt-dlp"
    fish_completion.install libexec/"share/fish/vendor_completions.d/yt-dlp.fish"
  end

  test do
    system bin/"yt-dlp", "https://raw.githubusercontent.com/Homebrew/brew/refs/heads/master/Library/Homebrew/test/support/fixtures/test.gif"
    system bin/"yt-dlp", "--simulate", "https://x.com/X/status/1922008207133671652"
  end
end
