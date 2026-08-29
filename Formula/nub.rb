class Nub < Formula
  desc "Fast all-in-one Node.js toolkit"
  homepage "https://nubjs.com"
  url "https://registry.npmjs.org/@nubjs/nub/-/nub-0.8.1.tgz"
  sha256 "50dff2a46370ac38ad98b289ba58d1835d9ec5cad5e38d8c658aea3f473cb9c6"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "c4653c49b2e2c2bbe4c2af364b160fea33df8401c8840510fb351fef2512fca3"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "79fc2164cb55b06314c28931aa01595b4e508dcea3b6fa5bf045a323c4d4eeb6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3320b0a7a2d06659c7be425df9fa8b0a459b8eb66255d4a099d5409390284086"
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
