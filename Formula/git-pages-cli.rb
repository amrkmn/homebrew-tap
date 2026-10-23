class GitPagesCli < Formula
  desc "Tool for publishing a site to a git-pages server"
  homepage "https://codeberg.org/git-pages/git-pages-cli"
  url "https://codeberg.org/git-pages/git-pages-cli/archive/v1.12.0.tar.gz"
  sha256 "bb0cb4261ebf2999cd301f2ed0e3aa128c5fa1dbce66c9cba50464197199732f"
  license "0BSD"
  head "https://codeberg.org/git-pages/git-pages-cli.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "8096b962fa9917b8a519414999e1870eda44dcd80ed8112f77ba81e4b607ad52"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "741b8783b13dee73f6c08bbd585ecf6e2f3db2cfe6c888d19e9539f80d553198"
    sha256 cellar: :any,                 x86_64_linux: "abdd5cc834273a86102db6d12c3ae389faf88d61d54e8386802c0b110b2b78a7"
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
