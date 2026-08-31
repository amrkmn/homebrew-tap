class Ttconv < Formula
  include Language::Python::Virtualenv

  desc "Library for conversion of common timed text formats"
  homepage "https://github.com/sandflow/ttconv"
  url "https://files.pythonhosted.org/packages/fd/d4/1f93adb12852678c02d1ad4805a190055cb4d32d89d4d2d0cc0163956ab0/ttconv-1.2.3.tar.gz"
  sha256 "74c8e12e5a591e42051606c27795835b663ee955bcd571835e7d884567335d74"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "6d7b1a77208d0c08c4d74e80bcca6db3fb019b13302b13cb7ee03e71f017e9bf"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "cc5e895e572cc695ae604175ef0ff21e96d5b5b949d3c39e4ce301a1d6174d0a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7656f33bc148f0a0e292baf9c2d5a50f0947e847cb03082d78057ac9a1621635"
  end

  depends_on "python@3.14"

  def install
    virtualenv_install_with_resources
  end

  test do
    (testpath/"test.ttml").write <<~XML
      <?xml version="1.0" encoding="UTF-8"?>
      <tt xmlns="http://www.w3.org/ns/ttml">
        <body>
          <div>
            <p begin="00:00:01" end="00:00:04">Hello World</p>
          </div>
        </body>
      </tt>
    XML
    system bin/"tt", "convert", "-i", "test.ttml", "-o", "test.scc"
    assert_path_exists "test.scc"
    assert_match "Scenarist_SCC", (testpath/"test.scc").read
  end
end
