class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.81.tgz"
  sha256 "4198e9a7c84a103cf843904dae7dace4f34e4ecfeb540d79c335bcf339680d92"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "f2dac8f5bd19730c79efda9a36b2e71687ed68a7ed694e29da857d5c2144cd8a"
    sha256                               arm64_sequoia: "00be42700ec321c2061f7f3294e9c5e3fddbeae3ccadb5b8be821d7d3450e458"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4bf04b234493283a7a46b8865632c04e07243f8948b65d7c6f2f70d7b8b1d060"
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
