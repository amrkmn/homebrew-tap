class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.104.tgz"
  sha256 "a0a3d1283a4004e8f89ea45b863e01d49c4e24ded53a8b27a87471337d51ccf4"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "48e5266569bd7400d0672a8f39cc661f6e5d1be30695473ba004006905e1bd13"
    sha256                               arm64_sequoia: "ea214b1acd2c87d48af5edac83c3c239b9297d6def3151df0439c7f94b6b6291"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7fe2bdc64769a9ce749044efd49cb004b3e80ca4fcdce951e9a2db5c240a4c4f"
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
