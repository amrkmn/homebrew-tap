class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.18.6.tgz"
  sha256 "f6cfc2ce4d864c901c6b86ff28917586b9294d03f9e6314acf9127946f9f9765"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "98df661e90a580652be58deea95dc94d1b8aeb5619120737ab4d2a581554c562"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "33f5c4686ce4217d3d54e15db286e7127685a634ae4c4e4c3c844246e7c40852"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "690c1cfddaa820381f3a0d9a4178aa3dd4fe7ed83fcd21379c5a6ec0226fb295"
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
