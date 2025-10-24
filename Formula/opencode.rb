class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.15.16.tgz"
  sha256 "c319765abf09da3f4596eeafb0954eb0b96baaf7b388fe6be6a0eca7fdb0d306"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "faf6f1338f981fe094a2dfe7cebeb3c2a797593d0ab56aa041bc8e40815a13ec"
    sha256                               arm64_sequoia: "3a73a059b70c2ff6e55377eceea378fbaf2bb078fe3588901741cc45833b5d55"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "556f0546a05275e27e96d47489a7b23133a384fcc63a5e1ec239d634e5dfa348"
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
