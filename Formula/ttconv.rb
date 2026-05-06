class Ttconv < Formula
  include Language::Python::Virtualenv

  desc "Library for conversion of common timed text formats"
  homepage "https://github.com/sandflow/ttconv"
  url "https://files.pythonhosted.org/packages/52/e8/c514652a91728a5b1ce01fab2cf8d59aeddf3e565a455861db991e5c2403/ttconv-1.2.2.tar.gz"
  sha256 "c0597dc04d1076192b94156dbe9d1e7e113d1323a1802ecaa062ccdf70b04d16"
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
