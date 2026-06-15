class ActionsUp < Formula
  desc "Interactive CLI tool to update GitHub Actions"
  homepage "https://github.com/azat-io/actions-up"
  url "https://registry.npmjs.org/actions-up/-/actions-up-1.14.3.tgz"
  sha256 "6d1575c45ce93e78d0a735477cbf842060b42d7ac08634cd90213d183b447b5f"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "cab3431a647bc7b572d6df7910011c9f46b14b886188b9b718063bf145b12b59"
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
