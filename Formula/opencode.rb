class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.15.29.tgz"
  sha256 "61c03c7c5ed1d311716826d36677bed9234f1283e79cf062f482581820c7ff5f"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "c6b954ffe86b77f5511952e48b29e813bf742d79f2ae495d297a34fba984f522"
    sha256                               arm64_sequoia: "7471567a28de61432d9b248fb26fba9063b29fe95737de1bb4a048bc2fe06c19"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6d3949b6aca18d4a817536d79655525a3eaf1f277ce1dedad5ab1ecdac354489"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/opencode --version")
    assert_match "opencode", shell_output("#{bin}/opencode models")
  end
end
