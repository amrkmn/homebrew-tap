class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.15.16.tgz"
  sha256 "c319765abf09da3f4596eeafb0954eb0b96baaf7b388fe6be6a0eca7fdb0d306"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "003ac89608d240d11b8712cb89d91694a08f8a2f8151d088c3350ec642c05528"
    sha256                               arm64_sequoia: "dc0f3161db1fdb0f25c8af10989c3d0c5eb0910a090f8375bb5cbc3fb27b5004"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "391ad61f65912a34679e21f967813add59222b4a02bd3c61b5f1486cc789ad20"
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
