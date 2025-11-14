class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.65.tgz"
  sha256 "5887386e46a7bc8148c42b92dbeba5d5745f8f47ed3801a2b3dc7c62501f80e4"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "f9fad81834b2f33a7f14f8c54eded594fb575f007653ad1c4ba9f7f3e9d89f97"
    sha256                               arm64_sequoia: "fbb815a41ec827b6c324a375dbc8da48f06641d5b4af0c2b223226e7280ab563"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7ce6e6b84286046e1d46b926ccdb5757c006f3028d411525f9296fce19f5b0c7"
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
