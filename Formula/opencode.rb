class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.15.5.tgz"
  sha256 "bf1f1fde33ad54c3616a85b567c7d55ad8ceda2a58c8022d72d6404f55fd0ba3"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "cfca83a5a94e98bc9dbecd823ed2b8ab5e5ee46326fc1687202614f578997fe5"
    sha256                               arm64_sequoia: "88a464fdf846a551ff09a2dd4ba4f3d5900aab6fe87c852cbc64d41eee9f12b6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b3864a151be3d7d1f339a97b4aad64b671cde14d1bf07b6d45be11dcc9498030"
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
