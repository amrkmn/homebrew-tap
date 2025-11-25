class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.112.tgz"
  sha256 "555cd4636a528f0da567d00c1e1260da5e80c11b5c90026cc90a91e5b21259bc"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "e699e24570e70f8c5f54bdb1fc26d74826e5c4569e237aa94f1508a9f49a25e9"
    sha256                               arm64_sequoia: "083c914b3822135da1bb9a6146c15f321d10ad78a05a84fd4d9231ec36bde568"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "18bdd679c73fcde822e96e2693de2cae20aabdc701cf5843d973d867dac782b8"
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
