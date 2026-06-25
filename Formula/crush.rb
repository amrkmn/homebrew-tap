class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.80.0.tgz"
  sha256 "cc8ba3a299ea192b9815f9be53c91ed99c86589c9f1bc137b97e4a8e4d3cf5f2"
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
