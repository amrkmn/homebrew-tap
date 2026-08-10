class Nub < Formula
  desc "Fast all-in-one Node.js toolkit"
  homepage "https://nubjs.com"
  url "https://registry.npmjs.org/@nubjs/nub/-/nub-0.7.5.tgz"
  sha256 "610efc05dbb4f212f2b5db36546ea889abec018bdf81c18955f3d0da8dbc16ca"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "bc9c93c001712af3f240277c1cd245636a10d78ba415573c4c42d423491627fb"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "725cd048ba445b9290c1b6fbdd1408eb6e92c6deb77242b01c984b41241a8538"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9f9c4b0cbefcbb91d176a0d555e158846b79c655e1b2eace2873d0d7fa265c33"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/nub --version")

    system bin/"nub", "init", "--yes", "--no-install", "--no-git"
    assert_path_exists testpath/"package.json", "package.json must exist"
    assert_equal "Hello from Nub", shell_output("#{bin}/nub --no-check index.ts").chomp

    assert_match "Usage: nub nubx", shell_output("#{bin}/nubx --help")
  end
end
