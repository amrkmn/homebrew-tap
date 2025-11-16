class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.68.tgz"
  sha256 "866c8b3d4e12844e90d2a88f9c4ef97dbd11b25aaab0973fe5523f7deb94485e"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "68361333f2aae9d4b81b78f00346bd443563341493812a7c51cdb5364650dca1"
    sha256                               arm64_sequoia: "10e1f434373476a470de7a22e05ee3acdd0d1dc14028da44604937701f41156a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b68365161967bcbff78c12b90f828483202d2392b60a6110e3127da2275bdf88"
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
