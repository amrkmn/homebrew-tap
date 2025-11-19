class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.18.4.tgz"
  sha256 "8c6a0b037d6330aa79625cfad014ce8a0a3969aa5fed1c20df7e86baf945aafa"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "2d4c79d172b56be31f2698e19734140825c26397c7b04e14c239d0dc69c72bf6"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "131e6e0bd8680626b31bc0edffd6c78ea715d6f887a462dd8b6af30d1ca29c49"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9320cb68a516f35aadd47dcc110386723fbf5f1f389b89436a7025d39edda2dd"
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
