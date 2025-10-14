class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.15.3.tgz"
  sha256 "48cb3c552dba17e5c46338d7ea0bc39246d4d5a48e92f0ee376db89cd6f28c12"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "972344b8696d85a17c1f052493a849c44064747b59eedd0502c3d9c33f01ca3c"
    sha256                               arm64_sequoia: "ff1f8a43087162bb3a3cbfc57c798e89d8c03982c9ed1af7dae56ca279f23262"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "dfdcd378940ca9dff15a505777a04fd0d24c178b0106123574c1102280c7c410"
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
