class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.79.1.tgz"
  sha256 "27611280375b80aeed3c5a7870c08228342b528863eabef6c838101975f6cef2"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "250a7dcd9b474b17a6be04085cc5477c76df48f92e02b36883a2990e631fb1d6"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "a0135ec1def923600acc05307709a0a2d6ab3fc301c7cfe8ed1ee6f4d172d570"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7fd37acead1277ea520a35b550a15d7bb9250e648eff815890dcc576bd50f425"
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
