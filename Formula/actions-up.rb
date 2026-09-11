class ActionsUp < Formula
  desc "Interactive CLI tool to update GitHub Actions"
  homepage "https://github.com/azat-io/actions-up"
  url "https://registry.npmjs.org/actions-up/-/actions-up-1.20.0.tgz"
  sha256 "43be99d049d9c2f59e78fe4d745c2b0dc58da585d90d7a7fb891b6f4171652d0"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "604dc7ed002317d2806a077f787a0170795ed9e8df1b6347252b4af6adda0873"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "e5f3e844f1ae8f76658e26bf7b3166a1af33c4c41db8e144737e02cfb1ce0216"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "eca6503a3c13ed32892ded3bfaafd1d672f79f6a91a32dca11c7865ab6eb7067"
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
