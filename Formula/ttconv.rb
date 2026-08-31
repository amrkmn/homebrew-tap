class Ttconv < Formula
  include Language::Python::Virtualenv

  desc "Library for conversion of common timed text formats"
  homepage "https://github.com/sandflow/ttconv"
  url "https://files.pythonhosted.org/packages/fd/d4/1f93adb12852678c02d1ad4805a190055cb4d32d89d4d2d0cc0163956ab0/ttconv-1.2.3.tar.gz"
  sha256 "74c8e12e5a591e42051606c27795835b663ee955bcd571835e7d884567335d74"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "94c0e5a512fa056f44c00ed136c70f5e340412789744bbd51b749780b9f28923"
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
