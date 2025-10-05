class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.14.2.tgz"
  sha256 "4751a967e1152585bd96a9cc06268c1c9e3ffc035bd0cedaf005f012db92ee4e"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "645f8e07b4154fe448f958faf032f596abb95c4954f0df101bd956e0dbb05c73"
    sha256                               arm64_sequoia: "449779b1f0cbc91ca52b4858caf0c58a28416235875e3f2d46208ef0262da423"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3f9a9abdb77bca1bfa0ca786be098f3161979bfa988e654827bc29272f45e606"
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
