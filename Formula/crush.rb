class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.15.0.tgz"
  sha256 "05797bde9ae055c39319e64aad1bc7b9f2e72a63942f630a4c58f12642da4c2c"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "56a001c0fb790ef174903810ec614678a08a7321251d7ddeef418067d28e0d3d"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0052734d2285925a38b02845038c37ea249a9c3aeaffeb17314815023045bda3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "793e6d71eadcfa570d45adaf67687baff41440eb5fefecc5cf9f84e02866a504"
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
