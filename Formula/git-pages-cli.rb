class GitPagesCli < Formula
  desc "Tool for publishing a site to a git-pages server"
  homepage "https://codeberg.org/git-pages/git-pages-cli"
  url "https://codeberg.org/git-pages/git-pages-cli/archive/v1.11.2.tar.gz"
  sha256 "b8ea09ae492fb4dd854692b5c8bf0b3dd5a2414f7b5ddf1fb6a15f2a7da26b37"
  license "0BSD"
  head "https://codeberg.org/git-pages/git-pages-cli.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "145982d2733f8867378fd252a70b23065e5d1e51ac812cb1a31c141eaa8d30ed"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "7db0354027c1850cc90b2157ceda003ac5eeb9416e470965fe027dbf0aee328f"
    sha256 cellar: :any,                 x86_64_linux: "10638bfc840702000afe31eaed5e8113a41625b324485c2497dde8fa1c260a21"
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
