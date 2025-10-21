class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.15.10.tgz"
  sha256 "f651f65e049e05cd3fff577c379c25b042dd51160ac5064a285dec317cd233ad"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "eaedfc861ac35bcf861c46dafff3973eea488894e6a72a519228e3ba775bf3a6"
    sha256                               arm64_sequoia: "04b1c079257a74ee2a95a9b4fb5769f82b22c5ac03aa2232cfb3cb580cf4632f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "dc9010a9b11ac98588af8e69d8f66caccd5155f243b77ac126f247c92b5e7df5"
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
