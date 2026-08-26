class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.91.2.tgz"
  sha256 "0052dff6d3714e039a6920886856d56aba0c04264965ce6d26206cf87921d655"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "755027ed90f00717577b37ac6f7701dd7858bb8df1f121dba2a9e72e52210a9f"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "16e2493c975843aede3343e28e0aa7e56d88071f8c872db01a9e54367004bffd"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b1142e0e9d7f5527e08e26c410aae1e10b76ab2b09d5515e58e07abe37e89d84"
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
