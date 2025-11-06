class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.35.tgz"
  sha256 "bf552e5213aaae1f18c3274c16065cf98d350a08e295d48c5c4390e4eee9e4b3"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "1ce41b126f484f788bd7838f8971f39eaa3db74ac36feedbd3f388caef22a31c"
    sha256                               arm64_sequoia: "0764bbdc4aed5073a4c393eb1eec1aeadd8c79b31060ec1db525857e0d5e9b80"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2edf487aea28f9e8e671585401cf5da1e991ac5a6be5c426a58d3f82d9e79ea1"
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
