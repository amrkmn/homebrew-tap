class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.94.2.tgz"
  sha256 "ce3ae0f3b7f460981291723be6a78e189648b999f7cf0b2643bdb0d3a47956fa"
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
