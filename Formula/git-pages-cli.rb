class GitPagesCli < Formula
  desc "Tool for publishing a site to a git-pages server"
  homepage "https://codeberg.org/git-pages/git-pages-cli"
  url "https://codeberg.org/git-pages/git-pages-cli/archive/v1.11.2.tar.gz"
  sha256 "b8ea09ae492fb4dd854692b5c8bf0b3dd5a2414f7b5ddf1fb6a15f2a7da26b37"
  license "0BSD"
  head "https://codeberg.org/git-pages/git-pages-cli.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "7624abd601a3605792bf3ca7c8aa115f63f07797b116df6b8bbf8329d485a336"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "7414975e0cd652d73372174183571ef0af6541ffade1d657750dfc014e0e3bac"
    sha256 cellar: :any,                 x86_64_linux: "738c75eaca566fc847dcca174f1965d1e9bc8acfd9df769f03ee0ac192e8101a"
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
