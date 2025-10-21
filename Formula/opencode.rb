class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.15.11.tgz"
  sha256 "def8b3019ff91dfc7dd9af346eed9ddf9443298777ff4bc902174f1f7d72e49f"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "09741143bdc3a6514647463b106651a14193b480319c505cd67ed3a1999994f4"
    sha256                               arm64_sequoia: "dfdb75e59e84a3ddfbcd8edaf0af32456e32c790d7a36c1ba20d4c39e059cf26"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2ecb367507695e4c735e60804d3598a58e3133e5fa940702cce1d7faa5ad8431"
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
