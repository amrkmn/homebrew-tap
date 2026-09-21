class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.96.1.tgz"
  sha256 "5a4982ce0a1cd5a2572b6df9c5a42a4c48568e818d4840218e2cfc593bd4f9c1"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "7050e0cc0a5013155a21d8b0089d7a0381eb92bb5a8febf67d35f3f08a113091"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "470346ceb348ad4803ba162c756e1b6aba1dd8c922fe5feb187583a790ff64fa"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bec0e8c127f0bc28d1d59a14afb3f8caf1441234a3afb6805d3b1bb539b04fdf"
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
