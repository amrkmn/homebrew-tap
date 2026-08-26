class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.91.2.tgz"
  sha256 "0052dff6d3714e039a6920886856d56aba0c04264965ce6d26206cf87921d655"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "021d2efc1cae7f1cf9ea43816ff14c635d411fba8a8fcad4140277404eaa2b98"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "b2ee9063bfd2c50d0748dac7237ca84f4b4e334533100a872137ce587dffbdb9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "eb392c97a7dbb954217473942d1da9ba9985139b7be5aba0fb7828436cdbe074"
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
