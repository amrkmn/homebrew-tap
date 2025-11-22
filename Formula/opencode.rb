class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.98.tgz"
  sha256 "b5e83330788d53de265472e847c8c8e1b967760ceef402634ae060d5a2302aec"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "d02cd552c78f80044aeb9f0a6e83c7651c445b282b74dc2b5953093a7fe3fe20"
    sha256                               arm64_sequoia: "d4b2c71fdbb705386dd23f2729d931a10f9d896184ae123371832001534a7515"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "39a54199daf511786e384098fddd63f6e392e95e344b96df17fd8a95ae9b76db"
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
