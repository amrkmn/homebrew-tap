class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.75.tgz"
  sha256 "b7a6157ca3979d0bb1e2395b780b2c3878f72fce8d1b471674be403ee858e6ca"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "08603880843b6b91a481ac610d85ba54ee826683f241cc93a0710ff1f586e1ac"
    sha256                               arm64_sequoia: "1a535b0e3cd105c02ae403140f792ccca4ef0a286c5993bb0a635dfa7925b5b6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c25aefcb81840d35493767ebb7d4ab63c32ab3d8954c1e68f145510f6cad8322"
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
