class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.96.0.tgz"
  sha256 "eed3eb9ecd5172e271b41b0059022a475e586ceb48f6fea0148b45980f2acd06"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "e823ff1eddaeb1191c9d91cf01f5e6ead8121479ae38fa8264e1fd6a63d752ce"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "a554b34bf84e6bf8d29e4fc6e7854b296a4347b8812ff6465d2bf1f9d1984d90"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ecdd3cd69a1b89b1f3d98dda279a648779fc1029df5ba54c2decf21d620fd74f"
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
