class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.12.3.tgz"
  sha256 "942e9dac82329f022ad1935adb7ea5ceb07aca1b8ea9bdfa141ff6f4e46b69fa"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "dba0c2d52c6ce884d35ee1d73a3326abde807bcdb18c7a09a3c7235cc237c423"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "899f3993fe1b63b98b433564b0a1c8cb131f85c2e98afb6279706ade7dda2847"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7baf3251a056a92f07e97727d670bca25432f22ff8bfb2fdb001cf862fd8bb72"
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
