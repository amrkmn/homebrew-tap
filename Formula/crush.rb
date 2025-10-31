class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.13.7.tgz"
  sha256 "1fb50f4ba1ab4dcf574c03f71f9708ea778843a34e71310eed6952e8d1945dcc"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "107a234e178f24f7ed2fa9d0bb3e8d5cb6945a504119ab436cbe8c4fa9c79a8a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ff9181ce6613c19b2e204bd83987680e937fdac65928b575cd4713a860254197"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7ff5754ae1dd5eae41d1a11eea77e9cef8824aa19458d9aa14e9bf1e064e75f1"
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
