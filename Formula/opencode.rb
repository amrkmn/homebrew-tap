class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.26.tgz"
  sha256 "7f575e31725caf3d6a49ed75a72ed87e51f664b7a1f6b91c2e8b4b9c6c668b3b"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "c6b7451c09176f79b84109f16dafb369e1d4f897720d792cdf07e5430f36a501"
    sha256                               arm64_sequoia: "4c83107402ee669cda36fa7322071038d27fd39e36342debafebf2fd687dccbe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ba7c56516c4ec9be4a120257a16d1d845a11c59ff39097ce379ab55049a2fdb4"
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
