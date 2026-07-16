class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.85.0.tgz"
  sha256 "1fcb2be3a0ee03da40b40eb84c59c2ad5a6fc4d4f790a4feb9abd5769ffcf4e5"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "847ba39943f1ffad3d7924d1cb3cadb33145f6577774672684d13ef454614d1f"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "28f298f584ef3d982be130e94d419942ad1d4ddeefc3c0025d7d8386fc08a857"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4531d4778b03d51c8a666efc59e4bd2d637824d4e61bf533844472c11d209efd"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]

    generate_completions_from_executable(bin/"crush", "completion")
  end

  test do
    assert_match "crush version v#{version}", shell_output("#{bin}/crush --version")
  end
end
