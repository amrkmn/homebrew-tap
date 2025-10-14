class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.11.0.tgz"
  sha256 "dffaa51185d3e0e0a2223c593dc3d2eae908a7e36df752672cbdb7f856c935d2"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "dc07b30bffd8535557f221c0a64fd6c21c6c5383694ce591768abf00c896fad3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b6822807278d900113040c7836ecc3fe29a24f45defa861ce6da4f72224c9022"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a1704b1826fef5b009fafb273a3d3c00988764b2db43988deba1ce45f09afd84"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]

    generate_completions_from_executable(bin/"crush", "completion")
  end

  test do
    assert_match "crush version v#{version}", shell_output("#{bin}/crush --version")
  end
end
