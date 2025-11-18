class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.72.tgz"
  sha256 "c662422a66d52a66d338eff1a204fd20a329bcf321dc17fdbce3fd62213657ad"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "f68318334aa10cca1a2d575ca0d0ff069cee0226e2f08e826b1d878f58db7106"
    sha256                               arm64_sequoia: "292a8d3c84cac633d82246be0305b44de9f391bdaf9e09e3520ecec9e9506eaa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f2c758ec7585bc70ab091509118580a2c1b17ce0959165a0171e9a8007b311e8"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]

    # Remove binaries for other architectures, `-musl`, `-baseline`, and `-baseline-musl`
    arch = Hardware::CPU.arm? ? "arm64" : "x64"
    os = OS.linux? ? "linux" : "darwin"
    (libexec/"lib/node_modules/opencode-ai/node_modules").children.each do |d|
      next unless d.directory?

      rm_r d if d.basename.to_s != "opencode-#{os}-#{arch}"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/opencode --version")
    assert_match "opencode", shell_output("#{bin}/opencode models")
  end
end
