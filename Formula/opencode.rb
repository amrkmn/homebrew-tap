class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.24.tgz"
  sha256 "feb5777c1ff0088196085f0ea4238019873a65493a3eb952d3136ce94a47b9c0"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "7afcd556ab7bcf1e99ca792d491a1d802e2526a0763544d15d16032538219e7a"
    sha256                               arm64_sequoia: "214841f856d31fccb7e757594d658cca98162963907199644b1fda04fbfef1e0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "86bcd8499c1ac9044fe9b772145ab33fb258fea1cb5ae1834cd5482067aa0496"
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
