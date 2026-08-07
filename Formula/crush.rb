class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.88.1.tgz"
  sha256 "e10f0bf514a5b0bd9c75136e5821efd8e150d5104d6ff41d21d43987ea397433"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "02a46433ed595a3b4293f0e9b37597c6aad687fbf6d334dc6f150b6bf59ff309"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "8aada1f1816c67b6427805200e9798ae0ae28d003173cc8b7f7a9eb44768862f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d27df621f083ef21f4d424f634cbdafa6e207f5536859acc70856a3142d1c809"
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
