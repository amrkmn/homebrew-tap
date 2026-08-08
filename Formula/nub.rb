class Nub < Formula
  desc "Fast all-in-one Node.js toolkit"
  homepage "https://nubjs.com"
  url "https://registry.npmjs.org/@nubjs/nub/-/nub-0.7.3.tgz"
  sha256 "997b206f280856fe9d1bd89ebb7c57b8b51361b80489497c83fbca0fdfc6c551"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "30d33b0d18c4955f02ff454763c93952fe991c90d92596966a4d07a3c2f570b3"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "22cd76eb55912c220ea09ec53360a6f39261b6cf0d59f94306df3c09af5b1b2c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ce6cf1bc95a790c6a13a7de6fde4375982647dd99beb18ce2fda41576575d294"
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
