class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.80.tgz"
  sha256 "d39a129f87d8411712cefba8fed98bec00df1d6c16a12551ca21f7ce45991700"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "10ce26bd2e742cabe827bbcca6dd90d9fc29042130a41161c383c0b96d8864d1"
    sha256                               arm64_sequoia: "7449e994e6e342cbbab75fc66ecb29f04490a596331bf935f9468ca1a181d0d7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "60e0f1051613e9b6de5b0ab62cc451b8e1034355188474bdf2ac43d3fe7fce34"
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
