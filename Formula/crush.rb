class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.12.0.tgz"
  sha256 "b2cf2bda8abaab3100c4b20c07810033d272d318bbaf2eefa34e12d69eaab9a0"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "c534bc113921d2334b525a833cc6882cd6ee068af6ba5ab537d54296e0d553d0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b9b93045dd86d5f72ace09a55610bbfeb214dd4d9afe5d7eed2a6a9e0e2b1481"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4be7702e5ab88af05efba1271ba5a0b213331c602d63506d0942d84a06a00f66"
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
