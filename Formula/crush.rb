class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.91.0.tgz"
  sha256 "6d74f4f07bffb2fa1e9e2738721eaa23340cecccf9527b18ba2ffae0640229c9"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "b8b0e9b08cd7b597cce242077fda38bac1bd061cdd705d53ea4d3b22c3ea2205"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "75d0a768b9e2da702211a244f114c307d117699aecee6761d7a24f62ac8a23e8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e78d308efc68726c4270eb871ac058b054cf697a9097fbdb8505e642e82b40cc"
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
