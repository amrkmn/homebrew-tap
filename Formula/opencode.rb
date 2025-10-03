class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.14.1.tgz"
  sha256 "7ac3713982bcf7af184c481c8ea2655a7384be16fa6926ab02c4147034657682"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "73a3d5e3bc691d96b6179468daddb1954a0f6782c6d0386026a39194fbb2dc00"
    sha256                               arm64_sequoia: "51a70a803b133a2cc787a5bcdebdfbd454b2c382b494c48f8c9320af43113bce"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8171126ae1d933b49b4808be3d7e250c310c480bd37cc4d68a26f8f445d9ae34"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/opencode --version")
    assert_match "opencode", shell_output("#{bin}/opencode models")
  end
end
