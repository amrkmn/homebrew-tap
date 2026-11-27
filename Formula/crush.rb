class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.104.0.tgz"
  sha256 "f86bee1d217d60b2777177764e5fb5f9e163468cb6eca45702008b9db2790f44"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    manifest_sha256 "3eb70d615356a8ed00c3b966e3db90f2ecc610b760422dd1a503a93a8806e7e3"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "2f3d68d208f0c4d28048bd84f5c61344fd11d96b76c6749232491c6357c21043"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "ae8e8cfc756bd702c8a4c0a720b76903640744d00fdbf209ca43d94650b5d18c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a503a7d86fee03f66984161ff0444d5930185622b44b2aa65a67ae4c6b1ef80d"
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
