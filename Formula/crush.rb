class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.79.0.tgz"
  sha256 "1424533494af7feae244d369c83a5537e4893b047be1725862e56bef36f016e6"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "1f67513c7a33ff28cbe96c94f6e998173eb8d0c25e0991300b76bdccaea40a84"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "e75901a4537d7ce778c6f37c9e363f699f440aceb37e13736d427a3c28dae606"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7b084847fe4d3046cdf9c9537dc50b7fc2bb4afd72e201fedbaa00b075eb3a3d"
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
