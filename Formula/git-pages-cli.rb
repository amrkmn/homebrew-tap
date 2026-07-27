class GitPagesCli < Formula
  desc "Tool for publishing a site to a git-pages server"
  homepage "https://codeberg.org/git-pages/git-pages-cli"
  url "https://codeberg.org/git-pages/git-pages-cli/archive/v1.10.1.tar.gz"
  sha256 "45b83e7eafa9fadd1b65d64ee67a9146ab44a182cce86450b347b8ec958f5eac"
  license "0BSD"
  head "https://codeberg.org/git-pages/git-pages-cli.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "f5f6c4484101831b4135a197f2e846d1ec8299c1411016d0a0f05563d11f270c"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "6d900283fce77c20a55533e0f4966a1564fbe80792bd37d711a8e2be042d3b88"
    sha256 cellar: :any,                 x86_64_linux: "14725d77a5400779b1d86bff1c6c89d1b720d01fc724c6451b8d8b553a509673"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X main.versionOverride=#{version}
    ]
    system "go", "build", *std_go_args(ldflags:)
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/git-pages-cli --version")

    output = shell_output("#{bin}/git-pages-cli https://example.org --challenge 2>&1")
    assert_match "_git-pages-challenge.example.org", output
  end
end
