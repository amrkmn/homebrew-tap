class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.81.tgz"
  sha256 "4198e9a7c84a103cf843904dae7dace4f34e4ecfeb540d79c335bcf339680d92"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "a89e7bd60d56307c3afd7456c8a450736a3da1e1184a940f9fc0b54a3b789738"
    sha256                               arm64_sequoia: "4294923a6cc3fa692a6f97aa5ca0692939ca526e5694f58de9b79d7384fcd67d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4011c650ba4f5025bf4d611d997e0622fd7f00df604aa0351be64f546408640d"
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
