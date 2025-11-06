class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.35.tgz"
  sha256 "bf552e5213aaae1f18c3274c16065cf98d350a08e295d48c5c4390e4eee9e4b3"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "f0ef9c97b8f6258bbb96221ca6eb19742a5d3663e7519601d7c7514037109758"
    sha256                               arm64_sequoia: "37250fff262463a8051552cd441b38b01b36cb28fac0a175dae1a9452dc4d0ab"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "866c8a48c30f1452a84d9c455627bc158eb69b379dd718ee6a167a7de36cfeea"
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
