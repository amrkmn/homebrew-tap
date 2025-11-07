class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.16.0.tgz"
  sha256 "553d283b35c5e0357bbbb007e94f5f6cfa4b3102b2a0c6eb0fb08cd83ff372fa"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "32bf1b76f53ee987ed430587abb9048594706f56b5bbe80bcb8430ab10971fc8"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2dbe3dcd405b89b2c955e39c56e92a90531d4b964abef971118c53ff39fa9d73"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f7e6e86750b838bbd94fa2bd6e877ab387e894010dca4b77bbafd564aea6aef0"
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
