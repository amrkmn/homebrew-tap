class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.114.tgz"
  sha256 "5ddf2c85cefc86e0447bc137502a28d96d225c3988b1f922222020456062a9fe"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "18aa9d4c1a0da07e82a0585f84ffcc893c7c940b9e61f50c9e093fb722c2e09b"
    sha256                               arm64_sequoia: "c13e32401d173013429ca8ae3c7bec04a4b9a27621e4096fc064c8e1a30a61e2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "30b2381ab4c6f7debb3d8a6d5bc53d9427f9a4b829afb1b6b9fb0dc7cb504505"
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
