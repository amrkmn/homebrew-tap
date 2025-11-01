class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.10.tgz"
  sha256 "b10dea019b416410bdfab16ff8a21c99a78ea7dd2cd8684d8f1ca47bffeeda94"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "f00bbde4aa3dcc2adb835d996e9862eec55210e680b271c3e4d592bab6b8da75"
    sha256                               arm64_sequoia: "339f6ddf32ed5ccf86c55e7cbcba3cb9631d5bfc3de1b69ecfd4f1a0fabef114"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "62615c3e21d900f864124864821d31418a2f8d7763b4bce05d4b720739e7163f"
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
