class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.67.tgz"
  sha256 "7efb1c190fae624ab34aa0819e1b37d95a3584c13fd034d7f77700cf8a214beb"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "93072bba69df5a8113ae39e5f0e733375ce58a95e4915c3f5911094a1b72088d"
    sha256                               arm64_sequoia: "5d265522f0945681ff38947a927646bdb8938971908a1b51655f00f322d69871"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7f2c6b16bb19ea371f740543e718b34287061f293d06336114879bb0087d4c0d"
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
