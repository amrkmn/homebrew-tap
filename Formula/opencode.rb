class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.49.tgz"
  sha256 "4518e9704fcad664c960326ab0de2862123666885dd14ac9c57885035fa26769"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "cc9dd06c47076841bcc637cc9f09b07de4d4b751f72720842bf141005ec65a3a"
    sha256                               arm64_sequoia: "3ad9984b8f38313342757356e39878e4c91b5a32f4bbf1477a4efeed0ee319f6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "91b8f32824f77094e3d198b248c1034aedc08f507dfce9e595a18282e66044be"
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
