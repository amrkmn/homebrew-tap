class ActionsUp < Formula
  desc "Interactive CLI tool to update GitHub Actions"
  homepage "https://github.com/azat-io/actions-up"
  url "https://registry.npmjs.org/actions-up/-/actions-up-1.17.0.tgz"
  sha256 "68debe4ee51dc3230f7d9865daaa28cf7da3ca2db8e165d3d7bf6eec37f54994"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "7a4a72aa0ee0431d4d9f427b3a856ade6361ce9582e11df7c5f41025268ae4c1"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "bebd38d561f3131eebb5865409e0de2af3bb6d6be2847e6944e89558d69358e3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "021a87c4c0338b63643cee6e87e30afec98cb49d7a1e799e2431b2c53aa85511"
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
