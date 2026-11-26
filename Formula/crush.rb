class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.103.0.tgz"
  sha256 "cc4ad85130b8f25387f8261128d0eaa73803b6354a43562b73125c9b221970ed"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "e365b1e02671cd8ec4acebd61794983a33ba0135ff7563e8462932c63d83aae5"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "910b0687110f6e7e31017a3e7edd3bae872ba09a5d75358ada96f2b6f9720235"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "779e56022f919df4490cf135f1d01721b1e4b4170cd6da37cfa9c122f8dd324d"
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
