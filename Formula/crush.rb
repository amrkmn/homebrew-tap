class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.13.4.tgz"
  sha256 "864a84b34ddef1efefcd1a6046c6c25680a697c5342a42949777c4b57096fc2a"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "141be88eabbb1e654ca88c7916c72b0afff23d0b3552e7f0bc61c98d41346419"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3e42f086b759d3c689453c789b184330d9d4924d41660ecc2d6853baa363e713"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b03d1cb3d8de629424a589e2e5315e3942501a333f4ea0f4813876d8825e4953"
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
