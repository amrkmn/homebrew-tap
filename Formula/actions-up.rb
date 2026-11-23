class ActionsUp < Formula
  desc "Interactive CLI tool to update GitHub Actions"
  homepage "https://github.com/azat-io/actions-up"
  url "https://registry.npmjs.org/actions-up/-/actions-up-2.1.0.tgz"
  sha256 "ac7f70a441db85163b7c690e901721894d1a7ce7249d6deaef25fc86be59b3d2"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    manifest_sha256 "5ee9d5ebc19053567275addca83c30f67d03982336ebc59d8a45345a5562943d"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "6267776fe108e8af72afcbb619479024ef04bdb851c2d1d7fa18533054539475"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "1e9d042b6bf25752b5905364d7668809404a4f7d48149c2f1c914c014667013b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3276205a8873dbab99e40fb91e8f49085df70d77c6a16c85b5d5b9c05f742a96"
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
