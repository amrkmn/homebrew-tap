class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.94.1.tgz"
  sha256 "9ff262ea92b2f1856ad4070480fb4e6d889f2f1e08699a92b375e516dcd3b908"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "702248b9abb89c671f1322fddcc8fc8eb2d68bec068944d0d826c4eca2485e6d"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "0c1554089ebd83ed66e37a91e045b927a5c567090efaf235594eefa5b0921177"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "afa427ca9d1e44cca0de152d4982bfde9b1467e7f7e019ebd829c8b102226dd3"
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
