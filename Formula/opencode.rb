class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.98.tgz"
  sha256 "b5e83330788d53de265472e847c8c8e1b967760ceef402634ae060d5a2302aec"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "38e5a3def4ab80269e68dd36c22ac8d67d2d03ffc52495aa8455b2538af9b290"
    sha256                               arm64_sequoia: "e6597445b3153232d2776b603bfed282d7dc807ac260ea50030355e4ae667f5a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5afe6a5ceb1d85f0aeb36e350e8829ccb76d68126726b1cd183ed145aef9e035"
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
