class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.63.tgz"
  sha256 "6a320bc0abf284ef9417973fa8ce4ee343be8f55d4013b1e87573b68b36b274b"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "78e2d80c74474f942e4e6b5a0e1b3dd2648b8f7f19f522375771deee45171dd7"
    sha256                               arm64_sequoia: "78e85da38c2b8c0ca4f43cf010ab3d9635f80d129e7619863f48c54bb40bee44"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b7752d10d5a0ed7713e7900c1f822d46971fc408e325e5fe8143cacf64abc025"
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
