class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.16.1.tgz"
  sha256 "a33f3b93e0e892f89cde12cf829f3738c90e7b5ecb87bc5b007d9abb2b71c98a"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "52d67bd0b19d02878c0c8f82c3d3fa011bf516a275dd884702161d69921edd4a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c6ce7902052ac73130f8a711b7a8e592198b1392539930f72562ed4a5fc15384"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bbeed29f3166f1259a485a432956baf73844337f307cb118b290dd65de208db7"
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
