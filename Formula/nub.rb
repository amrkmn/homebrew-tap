class Nub < Formula
  desc "Fast all-in-one Node.js toolkit"
  homepage "https://nubjs.com"
  url "https://registry.npmjs.org/@nubjs/nub/-/nub-0.7.1.tgz"
  sha256 "abb12b2822e91f8235d2439e4373b2df5d0d9c4a6aa8979c464d2493179f082b"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "5866c317ead470f287e3ba1d6f90095c0f9c51469d7ab70fc8023bfe14ac5d09"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "720827fdb28fa650993033c2adfb8fed61874d7a8393c935d334552121cdc8ef"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "819ed0f92e34193df8a69df50337801052244262af95af1436394ddb7c8b77e2"
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
