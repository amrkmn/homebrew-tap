class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.15.1.tgz"
  sha256 "99cbf6f1e3c7f00d671c21d990a815d47c3c315c7c51c111200daa11c4dea229"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "22e3c5c0f6d71933dad0a9f55ba130530e4f8181626d49b06241c6c4f4330bc8"
    sha256                               arm64_sequoia: "50fc9521dfef4c14c288052647faf84f73d3df7f7cac8654c6ad23531bf6adc3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "88a695ae54e0247a072cc98c0b2cd06e1c59469d2fb040f77984181d9b9938ec"
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
