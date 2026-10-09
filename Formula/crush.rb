class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.98.0.tgz"
  sha256 "d9829c423882ed752c3b18ce7cc0f688ac7cf0ed42b06a6085e48f1eb04c357e"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "acbe2dc69a4b16f18dd9f79a079850c0e7ee285847b319cec6553c4169df7bba"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "51ec74b2e33d0f9043ac146fd44e51769c8a6074fb9590bc35590a5d9605cc47"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7faf5896f6b958de06ff2baa00aab327d19f0055ad533c0108271d4b59beddfa"
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
