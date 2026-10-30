class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.99.0.tgz"
  sha256 "fdbd0d2197b8548e0b115b0cf1df58cfc1833cc291ef6fd66e33957d81ea0e07"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "408f2dba85019aa9cdeb5cc2615ed743f36407922c53f55ee57998e62d86825e"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "9830839a0e8c1f3c6138c33319a4e2e321d84c0788667a90c894781430f4638f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e7e5342f3b04804e35a0eaab7c04f42472e2cdf3c7ce50a48c734c6202c75666"
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
