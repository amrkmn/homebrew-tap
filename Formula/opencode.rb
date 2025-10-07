class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.14.6.tgz"
  sha256 "c4e3be3e6ac2e65f5c011c1eada18c3d093e42e6e0368a12cbd79af7633f3a54"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "3df67c2312c9c64178efd3c5557be48c83663462d29c5cdfe06003506e8991fe"
    sha256                               arm64_sequoia: "2086bef1c94cfb529fb4bc2a1d5172abb46d6bc2a0280586b843fc7d8a2af317"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "224382d5a4dd7dc251b87e2aa74838b9f1dbddb5440e4f2112cc580ac746b5c7"
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
