class ActionsUp < Formula
  desc "Interactive CLI tool to update GitHub Actions"
  homepage "https://github.com/azat-io/actions-up"
  url "https://registry.npmjs.org/actions-up/-/actions-up-1.16.0.tgz"
  sha256 "26c3ea5750a0fad9ea58923fb789c43f72b485c4414ffaa66ffc34a4ca7bb07b"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "230509b334aabaf4ec651f1f9186b126aae1d690bec56469157b9f7a97e22ceb"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "b3dcb66ac13644714650465f2caca52213bcb55d43e42b580a92df401f1b7878"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "21cb868547ace93363de5335ce7ff13f2f3ea45847f67d78a40cfb731f4272d8"
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
