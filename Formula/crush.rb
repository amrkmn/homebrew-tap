class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.89.0.tgz"
  sha256 "45d97cfde8fcfc1d7e893a28ced2c7df3f8b0ea931d7022ca89e10cecb1354d5"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "16d04407d7f14760b261b9239b8e733ba7a35bc04c6ac61d3b331e533d59b105"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "e9755b3d20fe89aec5a8f88ce9d992b567782de766322afbd4a85dbea71673c9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "985f5c264848dfd67d7b259d173cb519410bc32a0933312716df1984a0a85458"
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
