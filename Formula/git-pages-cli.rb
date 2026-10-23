class GitPagesCli < Formula
  desc "Tool for publishing a site to a git-pages server"
  homepage "https://codeberg.org/git-pages/git-pages-cli"
  url "https://codeberg.org/git-pages/git-pages-cli/archive/v1.12.0.tar.gz"
  sha256 "bb0cb4261ebf2999cd301f2ed0e3aa128c5fa1dbce66c9cba50464197199732f"
  license "0BSD"
  head "https://codeberg.org/git-pages/git-pages-cli.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "3be242a4f86b4813fb2f1007ab6f13e7fe881104bdbffc96d5f21158fddbdb05"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "fc48d0d520d7ed79528936effe97b6c8a1f9ed6ebbfc7fdcce32d19622d91bac"
    sha256 cellar: :any,                 x86_64_linux: "4d1651fe8c9c94a57cb09e6b5b4d0b3e6dc995dcc1ac4691c96dfe50cca1fb19"
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
