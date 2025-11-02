class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.12.tgz"
  sha256 "04c016a652e642bc6d4b4f41c4d605d8421b0b3dc5d3a698c84c54019c6d906a"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "000aeaa75efdbc4f457da44bc91472bc26ea7c98f145a2c670cc5c207f70a5c4"
    sha256                               arm64_sequoia: "e611f5743f7adc1236f75c647d6b86e2b1c5962101c5b4442346ebe726b534a6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5e5a1ece2d07e593e35f2600d22a761a018b9ace34cd0a120173847e5c8b692d"
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
