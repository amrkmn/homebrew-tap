class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.95.0.tgz"
  sha256 "21f7ec42cc4d3393e386260df02fde5acd0041f37cf6fd85302d73c6a1978733"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "5bc111049c697fe9e35d726c15d36d3a62f4a88aa60628c24be76647e0fbea51"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "1e6b1b152e68c4d2e96a6f497b27b48068b67e9950931364fd32c5b461d9c8b1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b6c018ec73b43d1dabd87ec2ee85738b0cf4b8df5d5b006c5d2d65d749de6fc0"
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
