class GitPagesCli < Formula
  desc "Tool for publishing a site to a git-pages server"
  homepage "https://codeberg.org/git-pages/git-pages-cli"
  url "https://codeberg.org/git-pages/git-pages-cli/archive/v1.12.1.tar.gz"
  sha256 "2be635f5219f45dd8fe7f993133ad2e88df255435399cd25f40860705cefc4ce"
  license "0BSD"
  head "https://codeberg.org/git-pages/git-pages-cli.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "c1377a4aa5b76d6f933d868c3e7f0993f8a0e29284de0077ea9f8ed7a3ea0e57"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "f3a7b098bf1c97d0a728ab5f5e6a1b657da9025a29f0c7044e19a50e0c0f226f"
    sha256 cellar: :any,                 x86_64_linux: "5da0d22794f0cf24b92234bc09aeeadbc06bc5db267ae4f7d35c0054ee0df76a"
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
