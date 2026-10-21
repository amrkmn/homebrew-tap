class ActionsUp < Formula
  desc "Interactive CLI tool to update GitHub Actions"
  homepage "https://github.com/azat-io/actions-up"
  url "https://registry.npmjs.org/actions-up/-/actions-up-2.0.0.tgz"
  sha256 "3be5a0eb9b3d91937266acde797050fce971a11f9f6f3a95f26ae882ccac876f"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "e9a1396e82ce28cb9be57884d4366c041dc2db5bef1e2f8e868802ab49924779"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "6218b7bb6b0dfa0b396913db526336bcff97e129b57dfc96f07c428d68403154"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0807c0feb0eb05bab37d373271830b9dcee7925f079fb33dac6218d417cd69ac"
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
