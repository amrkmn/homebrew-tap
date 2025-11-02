class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.12.tgz"
  sha256 "04c016a652e642bc6d4b4f41c4d605d8421b0b3dc5d3a698c84c54019c6d906a"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "a05b70ab19734abc54e6346ce47595e4c64004de0bad22e7dabfa933605fc3fb"
    sha256                               arm64_sequoia: "94569e1b4404d53fe86fd0004f81d071de9c5c15fd3099c8044a626b03749843"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5e3d209d8ed1b6874c889bc88a3147cd88e8f83182b4230b9c6330906698296d"
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
