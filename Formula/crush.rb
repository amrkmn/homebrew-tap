class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.84.1.tgz"
  sha256 "40fba375e518763d4e309738bed9e85378dabfcebc838a0259d781a9c0806cd6"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "939ff9f9ad5aa07f2d705b2a38a1bf764bc91882a30eae712fa587b7903afa72"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "b45714f84fb25331768fc961a8d8e1428bb3ef24c4563f16ae70c55d03a3e6f0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c98acb61e85f33511664d2e955871a40ecd4496757e594c9f58fd66a1d53a1ff"
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
