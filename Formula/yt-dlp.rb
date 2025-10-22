class YtDlp < Formula
  include Language::Python::Virtualenv

  desc "Feature-rich command-line audio/video downloader"
  homepage "https://github.com/yt-dlp/yt-dlp"
  url "https://files.pythonhosted.org/packages/08/70/cf4bd6c837ab0a709040888caa70d166aa2dfbb5018d1d5c983bf0b50254/yt_dlp-2025.10.22.tar.gz"
  sha256 "db2d48133222b1d9508c6de757859c24b5cefb9568cf68ccad85dac20b07f77b"
  license "Unlicense"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "a934cb0b6b4a23a6e15dbeeccb0a7f58ef90469f5942bbf07d4613f64b1da0c1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a9a86d04f7366ba33a71f8fb8237820c04f820545c413ba4ca12105072686a60"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1c387fe69bf4fc6430e9a098f55b631ff0eab7ef19ef5f6d45d83e3e83358f36"
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
