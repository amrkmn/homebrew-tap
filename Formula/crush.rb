class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.15.1.tgz"
  sha256 "f17ed9bd36dc081708239c00efe5b812aab5ca8833940be5311081ae4d1a1271"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "b4accc6fa10c38da80d35f52714144bb3729fc7c1fec7929a415f049030fa9f3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2dc57f463b3357b42d59eece0bc27d7e020f8ba09373e33169ad46b55c970ef8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "dda83f36de00f605c5eb1d5ff3ab6bb7e7a069d08731b72698d7f8c77a332d91"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]

    generate_completions_from_executable(bin/"crush", "completion")
  end

  test do
    assert_match "crush version v#{version}", shell_output("#{bin}/crush --version")
  end
end
