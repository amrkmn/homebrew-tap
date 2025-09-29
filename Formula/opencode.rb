class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.13.0.tgz"
  sha256 "c800c06b60475cf10293f94f1d3d35258291287809b73910b4a2e65aa1868bcb"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "e656cbeddebc2a3ca8ad6d10e426ec1bca5bf06817d1afa178c6dd52d3476fbe"
    sha256                               arm64_sequoia: "2722e387f519718040739209ae07e08bc861fda89b27bed514a39804fa78f1ec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c644ca93e311d1e3ce14cc62b6ed17ca2082f55e8567c9dbeb5f8b51e4c01f87"
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
