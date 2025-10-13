class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.15.1.tgz"
  sha256 "99cbf6f1e3c7f00d671c21d990a815d47c3c315c7c51c111200daa11c4dea229"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "2722885927290d19c63f6d7600ab37da4a09303d89cbda49dcdab5dade06cab2"
    sha256                               arm64_sequoia: "d7ea0cde4f199fde870b464d126c5d8ed357a5566cdbdbbd873ee7918f2e34eb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "58b4a5442e6813b2d8dfc5d5e03a414dc2a3fd7986c8bef3e6f0a34c02ba72a4"
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
