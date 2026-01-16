class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.33.2.tgz"
  sha256 "170779f9dd8dd8fc1eee50431f0f2e3d0c57ed4df50f5a8163a2489f18fe4a61"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c8059e4339d48b33a4d97d8957c3ba84b3902dcd3893e86a48e74c24b6ece6bd"
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
