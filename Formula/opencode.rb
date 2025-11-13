class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.62.tgz"
  sha256 "14dfc76c1f37b57d743d5743198b12be15a87a6cc8fc68093affd6833462d5a5"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "1d48cc7d5a88d01c7d9ca09a2158c16c82c4f73dc1a8f167cdf49bde23ddb67a"
    sha256                               arm64_sequoia: "8ef39905939771c4458e94631742ed829ae61522792f2e2b83f4131a57a5f31c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "14d24184b889c41b23decc2e5f97c92927a20202cbdbc69cefbd8b750152ad1f"
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
