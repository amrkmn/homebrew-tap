class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.110.tgz"
  sha256 "d5b25614735e3a8c84633970a8eeeffe971560c4a0d519e849b79ac0ed22e20f"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "9d8342ae581b4e692498cfd5a3e30ca48554bb23cc3870295b0c66229e9bfd14"
    sha256                               arm64_sequoia: "f0c05f4fbd7efbee217b2e1ef34c161707148cf06dc1b852058d8c8a186c7058"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0a1e8cd0ea95c90074857ca56b2745ed7b1e43d0eabd147b4ba156372306efbb"
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
