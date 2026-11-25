class YtDlp < Formula
  include Language::Python::Virtualenv

  desc "Feature-rich command-line audio/video downloader"
  homepage "https://github.com/yt-dlp/yt-dlp"
  url "https://files.pythonhosted.org/packages/c4/5a/1b6b13c8bf553841e7deaf204105dc63d4765aca9143def73a130da228c1/yt_dlp-2026.11.23.tar.gz"
  sha256 "1db83772a8de7855a2dab551a94d7f617c88629dfdf506531c06b369b47f88a4"
  license "Unlicense"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    manifest_sha256 "f488e9ed2fb127064e78183c05a90a3385dab716603c0b3381b0540dd4dfb515"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "044162774f637ed48de11a581eb6fc0ac7e62d22e39e1e68566056ae61190f4c"
    sha256 cellar: :any,                 arm64_linux:  "be1dec4f353ce19fa1d67372c0a8a529fc4c6ca8df8c297fea6e53c490f446e2"
    sha256 cellar: :any,                 x86_64_linux: "148b57217f56a90551f94527108aa4c681e96b08e669ab4a462451a6062429b8"
  end

  head do
    url "https://github.com/yt-dlp/yt-dlp.git", branch: "master"

    depends_on "pandoc" => :build
  end

  depends_on "certifi"
  depends_on "cffi"
  depends_on "deno"
  depends_on "pycparser"
  depends_on "python@3.15"

  on_macos do
    depends_on "pkgconf" => :build
  end

  pypi_packages package_name:     "yt-dlp[default,curl-cffi]",
                exclude_packages: %w[certifi cffi pycparser]

  resource "brotli" do
    url "https://files.pythonhosted.org/packages/cf/81/1546c983678a9b4e77cb4718eaedd1b2caf24a6cdbf1eb8775938d22aff7/brotli-1.2.1.tar.gz"
    sha256 "02b2f7b5a83485efe448a44ddf7983def05c3bb1dcf917d4f7154070260e13de"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/c2/c3/cae6d3bdefd96a941ffc247c714ac4babc488a69012e11c058f6c17c6c47/charset_normalizer-3.5.3.tar.gz"
    sha256 "a250888753faa289e2997962fbb17c4960cbdb58575533ca6fceee68c224bdff"
  end

  resource "curl-cffi" do
    url "https://files.pythonhosted.org/packages/96/4c/69074f9797d83a5401b3c6bc58c5de5aad6d1a085d0497b87a093a152e87/curl_cffi-0.17.0.tar.gz"
    sha256 "31ee8500d06d6502ce1ec0b7ded1c5aa8e8f3401bbe37ccd78d6153d859d8f3c"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/f5/08/8eea9d4b8302028f3abb2c0813953f7aec26d33b7a8960ed760e65ff29fa/idna-3.20.tar.gz"
    sha256 "a7db850025b95ded1eae8a46181a1a6c56c92c96f0e2b005d9ff8dc0210cab44"
  end

  resource "mutagen" do
    url "https://files.pythonhosted.org/packages/df/70/1675da133ea92227da41bf5b24e1c66be597ff736a1533ade41da986852f/mutagen-1.48.1.tar.gz"
    sha256 "8f95637ab9f6f305cec6bd1294e197debe207998e3e068596563c74f86b0a173"
  end

  resource "pycryptodomex" do
    url "https://files.pythonhosted.org/packages/f3/c2/f5855412372e47d635599a97c00cfcf9fc40accac9436a11bf9ded19f859/pycryptodomex-3.24.2.tar.gz"
    sha256 "e4dbc29e2575365d15e272f769329106277649aea081e2119cf43d66950f8f8f"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/ac/c3/e2a2b89f2d3e2179abd6d00ebd70bff6273f37fb3e0cc209f48b39d00cbf/requests-2.34.2.tar.gz"
    sha256 "f288924cae4e29463698d6d60bc6a4da69c89185ad1e0bcc4104f584e960b9ed"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/e3/05/b17359e1cefb4f909b5e40b1b90a496d987258916dbbf88e842c729f510e/urllib3-2.8.0.tar.gz"
    sha256 "63bf2ead4c879426ebf22ef2a781eeb4aa3b4ae798a0435506f8687fd5bb9b63"
  end

  resource "websockets" do
    url "https://files.pythonhosted.org/packages/75/79/590c5f0cc7d1661195aeefccb0e342b79f4c77d368d526d028821a390332/websockets-17.4.tar.gz"
    sha256 "09d3939b70df0c8ad2da145ebd50978bccaee1d565e838b0e7921a34d38571eb"
  end

  resource "yt-dlp-ejs" do
    url "https://files.pythonhosted.org/packages/d3/e6/cceb9530e8f4e5940f6f7822d90e9d94f1b85343329a16baaf47bbbb3de1/yt_dlp_ejs-0.8.0.tar.gz"
    sha256 "d5fa1639f63b5c4af8d932495f60689d5370f1a095782c944f7f62a303eb104e"
  end

  deny_network_access! :postinstall

  def install
    system "make", "lazy-extractors", "pypi-files" if build.head?
    virtualenv_install_with_resources
    bash_completion.install libexec/"share/bash-completion/completions/yt-dlp"
    zsh_completion.install libexec/"share/zsh/site-functions/_yt-dlp"
    fish_completion.install libexec/"share/fish/vendor_completions.d/yt-dlp.fish"
  end

  test do
    system bin/"yt-dlp", "https://raw.githubusercontent.com/Homebrew/brew/refs/heads/main/Library/Homebrew/test/support/fixtures/test.gif"
    system bin/"yt-dlp", "--simulate", "https://x.com/X/status/1922008207133671652"
  end
end
