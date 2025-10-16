class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.15.5.tgz"
  sha256 "bf1f1fde33ad54c3616a85b567c7d55ad8ceda2a58c8022d72d6404f55fd0ba3"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "5a36f90518f8355aac51350df5f383777a1c4cc63fecdef156f12d9d22898004"
    sha256                               arm64_sequoia: "d961c3e42c27320a95b81d437b8db444e909099372a18cba71347b72cc08f7b3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5c13032c55a4724f66f43bbca0b338937373ba87f83bbb59909ebc6a393556e4"
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
