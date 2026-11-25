class GitPagesCli < Formula
  desc "Tool for publishing a site to a git-pages server"
  homepage "https://codeberg.org/git-pages/git-pages-cli"
  url "https://codeberg.org/git-pages/git-pages-cli/archive/v1.13.2.tar.gz"
  sha256 "082f7bdf36380e2fe157c659efc91bc11c9584a0e043bf9322a6160723ce1a7e"
  license "0BSD"
  head "https://codeberg.org/git-pages/git-pages-cli.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    manifest_sha256 "ab01627eed12dcba7010d290e073bf0ac2033cbe35302b89f029a503ae32819e"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "f54a414a087c9fba4151455277356c8f96344fdd2db84a113381ef85235038e8"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "ef9067a3215a324bb9098c397a66c000fe529ad41688ba67b085c647b5c3c2c9"
    sha256 cellar: :any,                 x86_64_linux: "67f0f1d43b9af053d4724865eafa31cb0d6081e6cc5cc267bef7d0d709bb44b6"
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
