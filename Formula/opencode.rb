class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.15.2.tgz"
  sha256 "8f6c2aa7730e18bbc237ad2a0cbccf159a033140926719f5d3fcbc5f3c3b86e6"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "9f83dd0521e0b3e1eacad02cd0fbdbd03eb57c683167926694226ccbda96417b"
    sha256                               arm64_sequoia: "323ff7d5f69dead394be219e8fd2120e8d69903a2ad2be35e42ca09cea39de27"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "98f8585d36f279e78b4b87c1fdeb12f893d079af27eb577cfe10d14df187b6ff"
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
