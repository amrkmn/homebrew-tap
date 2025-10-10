class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.14.7.tgz"
  sha256 "8a67628d6ff2bf2f054001122cef06da81750999ce4801ace88500569ed0d9ac"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "58957deb6b7b389dc3761f5df11e892bc81296b6b812cb86dd9cac0ee5771b42"
    sha256                               arm64_sequoia: "f49e27a6ead1995726e51698e4222474d289e4b01a3d1a49f5795289d9a815f3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9a52988a1989c72b77518ada5da777f671ae0f2e9b4fbf0eedac49f848d3a89b"
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
