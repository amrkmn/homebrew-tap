class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.13.7.tgz"
  sha256 "329edd3e3ecf592967a501d36e0e7bd74c57b2c17957ec5373ef7fed595e1b1e"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "541414eb49f98c467ad6ad55288009d424d38ba33a11df7aa7eee2931ae68c65"
    sha256                               arm64_sequoia: "02fbe7ab06087d2e0d30a303f0eb45edccc6f423fd321478f86d6f6fbd395e83"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "04c2d6d9f6b77d1c140df351f9e910f15a7f721171b8ce7ba05e94b33f63cefd"
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
