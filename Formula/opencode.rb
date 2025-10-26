class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.15.18.tgz"
  sha256 "b63d57e068ba9b656263eb14a95f8458abb56d46a387d251669ad01008113fd3"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "43144c6ba887d52e5d06bed6672afd10cf275ee36016871e8dd3d9dad3a956db"
    sha256                               arm64_sequoia: "68a5d864ae2e1b60f887e9120d5129beb3ecd1cf54c691aa4c5f363ee8f2e69a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c475e1ef79cf7dc934a6f337be5911efca5a1a13e0d12bd6f06a0521d4290d55"
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
