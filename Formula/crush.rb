class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.10.3.tgz"
  sha256 "3056c39deff5da25612b8a45df88b565c9f06ad7c26109312c1117e7e256d68e"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "b355557b98210e10d86b540cac47502b4d1101a60791d23854aa8d91edd7867f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f42dbce7b4d602f44f03329c57bcac794644912ea18d6f47e49fa835c1a6db3c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f605579f3ac22ff76e43c439c089c22896da64a1e0c4c605cd1889c83ab82fcf"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "crush version v#{version}", shell_output("#{bin}/crush --version")
  end
end
