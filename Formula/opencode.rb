class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.2.tgz"
  sha256 "00fe980f49229acf6da45636fd854d8c5f2d3ca101d2a15b35594dcb59ea06a4"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "357daac15b9d129bb0d9ed0054cac0a24df0de998f114eb85b822d20613c293d"
    sha256                               arm64_sequoia: "b8f8f043c031a317c967047e851596deba22b97b45e416b1ac09c0ba9b03b4e4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "944da75c454d2b4f3ac451c71500514d86670557e8efd3f63efa2162b3d47e50"
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
