class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.12.1.tgz"
  sha256 "b3f542c7a0b47589627f6172236a73f4b8e379cda8b05c8484cb2ae22b7498df"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "e65602df863f173901368f91cf72132590528b48c0c82a6e91a20e4dbf771736"
    sha256                               arm64_sequoia: "1434f4c2056c55c40c84f901a84fc981071ca0bd6921d075397cf715f89ce26c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a627a37a6c417c84cdbb1571af82259eaaacd608be70b81c97f814934bd17a04"
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
