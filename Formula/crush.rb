class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.99.0.tgz"
  sha256 "fdbd0d2197b8548e0b115b0cf1df58cfc1833cc291ef6fd66e33957d81ea0e07"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "bd8b25ae845971555dfe4b58f1ee90e4d83820eb3f59004c82a022d678253fd7"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "78320de856120987e98593b021c0280eb1cf5cfc7aee62c0992c6fa43a93697d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "902a40068c6c222529c3a6175a9144a47ef2150c9bac5f3c37fd9382795584f5"
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
