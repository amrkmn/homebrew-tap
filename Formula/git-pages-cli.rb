class GitPagesCli < Formula
  desc "Tool for publishing a site to a git-pages server"
  homepage "https://codeberg.org/git-pages/git-pages-cli"
  url "https://codeberg.org/git-pages/git-pages-cli/archive/v1.13.0.tar.gz"
  sha256 "00ac20d5a1b977bd49ca2b6324647559cc9a79adacd7a47698ccc31cc980b979"
  license "0BSD"
  head "https://codeberg.org/git-pages/git-pages-cli.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "cef4c5e46f0f369d9ab11415f36c684fb339f1bb355e2ddb5beb20c11d5007b5"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "3a92f3cbe8bde14d5a3b1f24412409a599f421e4716f49b3feccfeec680dbc08"
    sha256 cellar: :any,                 x86_64_linux: "8f0c9f62b28f4b3e63b53d89bed688b801a7e604aee9e31b62fffcb41b4d476f"
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
