class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.98.2.tgz"
  sha256 "4befab0a4116c0bf8025ce1ea95d2335c3bf9ba2469b4ee0406274b6eb525f77"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "aba5aae1bba2d778a3d2832d82d31c49079f4f99d5bda07bc47951e672f795e8"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "45d35fcc8ce358234d48785356e108d098a4445f7092412e17628759e8d8c8de"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "083239f80dc7bfb377275a7fa8870cc932d4a7d1a49701e56bdee95965fc515e"
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
