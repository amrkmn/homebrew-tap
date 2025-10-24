class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.15.15.tgz"
  sha256 "ad48b8788e0ab4c486ef1c61ab91f60bdd871dca52297bb75bc2437561af748f"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "15e641ad9789cc83c97a72b504eeecbfd067cd76a86cca0c60460eb13af2bd0b"
    sha256                               arm64_sequoia: "67ad60ab577509b6ae8b537f7cf87191a6ecf53dfd561f5d71acaf512d2bc8e1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ff94254def517669e58d3fe1854406aa1e676236747704d2902dc021f562595a"
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
