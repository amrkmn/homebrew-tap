class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.10.4.tgz"
  sha256 "00ad049125d1bfa8d995ba839d4223777747121662eb04354cec36f1a101b8d4"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "de0fd142010b85bf7e29922c0c752861932e1265db5d2192181fcee3bc4cfc31"
    sha256                               arm64_sequoia: "0b811838807538fcaec4aebad2538cbd3d9259810158ceedbf2a833aeeeed597"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c10f1e28c4b868df208c6ee0af5dd92751a4d265972f21d46dd795fad2be9236"
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
