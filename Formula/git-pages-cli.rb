class GitPagesCli < Formula
  desc "Tool for publishing a site to a git-pages server"
  homepage "https://codeberg.org/git-pages/git-pages-cli"
  url "https://codeberg.org/git-pages/git-pages-cli/archive/v1.13.2.tar.gz"
  sha256 "082f7bdf36380e2fe157c659efc91bc11c9584a0e043bf9322a6160723ce1a7e"
  license "0BSD"
  head "https://codeberg.org/git-pages/git-pages-cli.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "888206e3df4e36674775e5e6740a8cf0f3b1b7102415209dbdb5655f8a9161ea"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "ae9f16d5befe2d026eeaf4af8ec3fd415b7bd94f28aa63a740abaeaa5b815b19"
    sha256 cellar: :any,                 x86_64_linux: "f9f5975bf2f6c0705ecf1406de940f7790c51cf082e87fc534e26a94eb8058bc"
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
