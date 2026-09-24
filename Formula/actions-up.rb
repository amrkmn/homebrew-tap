class ActionsUp < Formula
  desc "Interactive CLI tool to update GitHub Actions"
  homepage "https://github.com/azat-io/actions-up"
  url "https://registry.npmjs.org/actions-up/-/actions-up-1.21.0.tgz"
  sha256 "31cfb104f6354c1880b826f34fba6da522152cf71367f700abe10e2a262f47ae"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "d3d6d1607b969052beb844a2fac9c089cbd72c4c3fe3475cb10e0984c20dc921"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "6688fa858730186f3b373b2db240aa67f38da6fcec52aaf4e22dd61c7d50637a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7d85ca51096074ad4dc5e8b8c8fe43573408f3003554ed3d47de0fdf8f36c8f7"
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
