class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.10.tgz"
  sha256 "b10dea019b416410bdfab16ff8a21c99a78ea7dd2cd8684d8f1ca47bffeeda94"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "972e16964a1fe3d3e9b3a0f6cbc63997382c6b8747b40e8676b90e2153c6fe2b"
    sha256                               arm64_sequoia: "bf037b34dfa086db7f1d9e90eebb767643575088cede8d715cb8b7e935c09d7b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cdd5ec8685a4336cd45edbaa250fd4d10d4a2dd72df479a5f38f78fc33e7ed80"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/opencode --version")
    assert_match "opencode", shell_output("#{bin}/opencode models")
  end
end
