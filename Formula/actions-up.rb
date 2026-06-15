class ActionsUp < Formula
  desc "Interactive CLI tool to update GitHub Actions"
  homepage "https://github.com/azat-io/actions-up"
  url "https://registry.npmjs.org/actions-up/-/actions-up-1.14.3.tgz"
  sha256 "6d1575c45ce93e78d0a735477cbf842060b42d7ac08634cd90213d183b447b5f"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "0226fe8bc262531e49a72639677b13ec8399e608ad8085c8395f404d4cfe2036"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "d12e4a409265ae95f8e313426bb746d66052391b737a237d7f3d8921a85964b7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b26826bfe32a7d4d20730b1ba8d0ecb098012b3600ab1d29e0e7787660d0ae95"
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
