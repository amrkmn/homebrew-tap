class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.28.tgz"
  sha256 "59eecb8cd32aebb6f21fe28f1e3134c962f27c52424222eeb01801f09f428723"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "f4e93320b144f6643d5c82b4bb5448472d65d654daa8c97c19c3fc99d8c0bed4"
    sha256                               arm64_sequoia: "06693867bf2b3ecc14537c8487026dcb02e3946d50dcc560d5d225b283e99efe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "786fb0b265e1c407f1bd8f8ba29b40ea92aa59501bb84eb26160a9dc787fb1ef"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/opencode --version")
    assert_match "opencode", shell_output("#{bin}/opencode models")
  end
end
