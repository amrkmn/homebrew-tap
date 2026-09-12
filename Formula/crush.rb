class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.94.1.tgz"
  sha256 "9ff262ea92b2f1856ad4070480fb4e6d889f2f1e08699a92b375e516dcd3b908"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "a6a8eecddc66ba4a28ee4295eaf4328c939350e97b2a8f848e45cda4220f6a76"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "b83769c1c5c6b7a52a9c45b49e81341622524f432f5c72726393bf6e74f2593d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d8a92fdc9692ed203fef688b943b4d510050e73fcd059c9e2a035093993ae879"
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
