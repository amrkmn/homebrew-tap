class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.16.tgz"
  sha256 "9aaf04123742053830243598105410c20a0683ebf28dc47c9e4f32189c83d6c2"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "c1824d9bf3158104281c036e2341a99b935d52784e9093e71ddac196a434c8ed"
    sha256                               arm64_sequoia: "01576fb3e69214ee941033a58402005b7ef9c8de8f3fc48db5048b6804aca31a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "11b43a1f8baa7468e7165134f2ecf15047dcfc55737bd2d5b6d6911febf6d0a5"
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
