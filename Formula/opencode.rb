class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.36.tgz"
  sha256 "407f31644167acb130f3434079fb0e984c918f54f1a1c0037d245964184e3412"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "1d8811c4cfbda538c06452c77e0d7550c25146263953f0504cfb7702adeeddc6"
    sha256                               arm64_sequoia: "026ce2dedef4ba05997f9de5d6d037487e83dac1e05f33c84700ead3a4f5f9b3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4be268805489d4677721d54534a39b90ace2e1c9f384f439328ba9696994e739"
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
