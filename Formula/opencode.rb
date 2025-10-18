class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.15.8.tgz"
  sha256 "69c0eb3b19e84426ddb0eb6f56e01d0f8699c69425c07bbe3d9c57757b238812"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "049b23bba808c13da26ff71b606e9440765e3b8779ba72a6ef76bebf810a1b50"
    sha256                               arm64_sequoia: "2413b33161c2e67063bc07bd65ec22556c7632a6003e2129c710a4c398275d04"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b3d7407d093a34afbae90432e8946413a2e20e4cc88bf2c727271ed6b0f81822"
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
