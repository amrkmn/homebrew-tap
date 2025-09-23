class YtDlp < Formula
  include Language::Python::Virtualenv

  desc "Feature-rich command-line audio/video downloader"
  homepage "https://github.com/yt-dlp/yt-dlp"
  url "https://files.pythonhosted.org/packages/90/77/24a13bbd3190849e7e37e6093aa9648f3b26a836d37ba67e3429ee89ad1d/yt_dlp-2025.9.23.tar.gz"
  sha256 "9282ad1deadb4c90b2e6d3bcf9f360abf88c5f2e4ba836dad7b51387b086d757"
  license "Unlicense"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "69bdbc0a162d2ed8a3fb0505f18b7178672f857ecaff806894c4c2921f35e246"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c3a12ea68b16587c1163f3adaf9849b08b2826ff815f40e52cf4bef78b499141"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a7b6b5ea599cfa5efb15ede02b5184cf4ab30b846b798a9e38ec1d2422df0d22"
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
