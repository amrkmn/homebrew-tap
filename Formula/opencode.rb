class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.44.tgz"
  sha256 "11f041b5af678e9b8e054821ce9b2158d362d3231045c3312bbabd8641cbaefd"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "27c11cad61f925d6904beee106e5a615e877e5561fef743d02388e3d221e05bf"
    sha256                               arm64_sequoia: "29a0a0fff3d915c9e70512a57bfc6969f340687e63f302df76191ce47fc3dbd3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "90ac1260a39cb3628c3fa9a7dae48ba4b0dd193fe0a1e40a5c382687c9c75815"
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
