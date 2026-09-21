class ActionsUp < Formula
  desc "Interactive CLI tool to update GitHub Actions"
  homepage "https://github.com/azat-io/actions-up"
  url "https://registry.npmjs.org/actions-up/-/actions-up-1.20.1.tgz"
  sha256 "580f610bf1f98f1774dba0c770d4df65b34c07447929f3aa91de06030401ba72"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "b6db6dedb8376f4f27034b176097169e97bf7d76371276544cf130651eb80f16"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "25fc730f4d1fdbff0d11c8403ffe720f86d0a24fb01362879b27c501d76061ae"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "82855c3758d161fcc2ca458e7ed3e232fd6bd3a8f4325fcb1b7aea493a726b1a"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/actions-up --version")
  end
end
