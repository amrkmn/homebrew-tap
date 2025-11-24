class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.18.6.tgz"
  sha256 "f6cfc2ce4d864c901c6b86ff28917586b9294d03f9e6314acf9127946f9f9765"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "353af1bf42a6e29be3b7b26c7221897294868d3b70c2a9d76ee796d525bd0c6f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f24cf564ed1e304d63426ef1a593d9acab86bd15b1997ace18a3e06c567967ca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7a82a699cb0a439fafe9f54abebb18eda46f93b7b1254724df3d4c2a97b66333"
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
