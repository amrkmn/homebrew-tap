class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.16.0.tgz"
  sha256 "553d283b35c5e0357bbbb007e94f5f6cfa4b3102b2a0c6eb0fb08cd83ff372fa"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "18c303a965268e3828284edf06f6afbf4296cc6c690fce367f3bea8a4602f17a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "71c2bcd5b4c5c6d701e21fa663d264fc40a1bc62845c9664c3723e380aadc0cc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9cffcab64e79b6435fb67af03ef221bc3f79e0accfe7a425d001d5320aaba73a"
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
