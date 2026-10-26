class Ttconv < Formula
  include Language::Python::Virtualenv

  desc "Library for conversion of common timed text formats"
  homepage "https://github.com/sandflow/ttconv"
  url "https://files.pythonhosted.org/packages/fd/d4/1f93adb12852678c02d1ad4805a190055cb4d32d89d4d2d0cc0163956ab0/ttconv-1.2.3.tar.gz"
  sha256 "74c8e12e5a591e42051606c27795835b663ee955bcd571835e7d884567335d74"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "a1cf17bf8c494c4bb5fd901045f48fa0d0445e1908c2f6ea9a067470f4354c5a"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "0f621e5f09b5fc1d0f4786ac92b81d836f99c02e5cb9a13c241b555acc0e6196"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c8b0412a4e9f520f33d3d8eab3625eba65db35ce41c71a753d4dbdc99152d002"
  end

  depends_on "python@3.15"

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
