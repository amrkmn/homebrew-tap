class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.55.tgz"
  sha256 "1193162c390d75be2fb9372bf16d3ed7f8381099871cc0cabaacfe900e5428b6"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "2a7c27252934071ab34ea5894f8a55ee12f1406b03ffd07dee3fc23de7dd9347"
    sha256                               arm64_sequoia: "06aa2178dcd1bed93da38b7a5118a9bffb89d6afeba739729c770dd2fb50594d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "45ac494e3737d6977037fdb7d3003b5011fb075de5b29bf2836d11749e315a42"
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
