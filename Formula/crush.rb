class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.83.0.tgz"
  sha256 "3ba062b9391472e687af52015b637c6573551b10ce6638c0a5e737919b7e6d0d"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "ff635a1207133600d4e8336041460619d7271f709843a30f48ba20f9b7a072eb"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "bf6b2db20b2e220042bf38d9a28c8b8f8e2bd339faf5a225f94ccf3eac9de5ae"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7ed4ad373126bf780379218bd1c3b5ee8273a22d009cd3a39e66e344b648eac8"
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
