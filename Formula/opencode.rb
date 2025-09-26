class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.11.8.tgz"
  sha256 "35618c3e4abee555a2db98a678061d9c7cd3b978f41130862d9402d81f94ab05"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "69bf1f635f3fce0b0606c569c3b41a10f4b5f5200fe966373a2e782781e8ba06"
    sha256                               arm64_sequoia: "c6e689db027cb9167a0207a66139cfab0f216e42d2ffdfa4e1d2d875397e8d4d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "aeba76739210afe315d6a633a0cec3e89d8b4358a61375cf415a3ba71f8bf085"
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
