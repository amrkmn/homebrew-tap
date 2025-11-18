class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.72.tgz"
  sha256 "c662422a66d52a66d338eff1a204fd20a329bcf321dc17fdbce3fd62213657ad"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "8edfc923feb11f7464d046ec95ea57ecf50c42374b591f9a3249c4a3d5288b81"
    sha256                               arm64_sequoia: "1419b17ffb46f1a9bd12c0358445fec0afaba90c94b9b98d1e743f2368ad3e76"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "414f62a3d68b502ea1ad06390fd17d4dc578bd473c94d2d10236091c86b927dc"
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
