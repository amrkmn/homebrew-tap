class Nub < Formula
  desc "Fast all-in-one Node.js toolkit"
  homepage "https://nubjs.com"
  url "https://registry.npmjs.org/@nubjs/nub/-/nub-0.7.2.tgz"
  sha256 "d9b7500a617a3e7cf9d00db995aac129f15d497c05ca15914e2f0ff5d4f7d46a"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "c430c30b15d70a6997a2f5c814167c5b4b4b1613f4fe06f7f94f5ce607f02998"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "bf06b271317d95d1cfcf43b35df4f46ca4d3d0aa6b0531c234e45817001e76ff"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "616d882da7961efdf5e61a4a8337dae729f932c5a2e2aa7f4f58ac4a77a1829e"
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
