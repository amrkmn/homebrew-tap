class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.13.5.tgz"
  sha256 "acff4368dd4b03b0a04aa18e00aeb131bfe3ff4414fea9bc384b7c9d1ad57353"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "7dff1227027a6cb8337fd42cb1ac2b9a4c5c474b9712c7d9c9f6b00cac05cacd"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0ced6716a3ef4ada4b42ea97e024beda071e97ddce89b66f0ea8620db1fa9a95"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "94316bb02238073d3607ae13424d6cd8e80c167cb7fec748f2a4457f392c4c50"
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
