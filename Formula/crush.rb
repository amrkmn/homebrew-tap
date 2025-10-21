class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.12.0.tgz"
  sha256 "b2cf2bda8abaab3100c4b20c07810033d272d318bbaf2eefa34e12d69eaab9a0"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "3567745bb1f5c1ea8e46f29b41dcf3845cc149e486e97e4e28c98857973f3adb"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "60551f553a7c3fe14b9c7289bbb7bb51583825cdabfa5b65ab553ca4ce509e31"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c7b2da6e0cfcd539a9d2aba50c74ff9a79e58643e9cf0f391908c1a93aedc778"
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
