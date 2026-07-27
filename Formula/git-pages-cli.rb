class GitPagesCli < Formula
  desc "Tool for publishing a site to a git-pages server"
  homepage "https://codeberg.org/git-pages/git-pages-cli"
  url "https://codeberg.org/git-pages/git-pages-cli/archive/v1.10.1.tar.gz"
  sha256 "45b83e7eafa9fadd1b65d64ee67a9146ab44a182cce86450b347b8ec958f5eac"
  license "0BSD"
  head "https://codeberg.org/git-pages/git-pages-cli.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "73d3fd10b353f0b2ace33706667a90d0c8548e5d7fc99b637c5a4335ec715f0a"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "5a7ad5b50365e8062b91953c2d6e28a6c8dd672b20b9d36cc7a069a8ed7c651c"
    sha256 cellar: :any,                 x86_64_linux: "54e4c7c6fcde9f5db0ef12e1e42b83263eea0d4dc8183510f1a0953c7e0ef70a"
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
