class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.11.8.tgz"
  sha256 "35618c3e4abee555a2db98a678061d9c7cd3b978f41130862d9402d81f94ab05"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "93b748b6d197a27735e625f7dc68fc031037b3121216c8cf3f1ddb723f4f8c0a"
    sha256                               arm64_sequoia: "ba5e30bd58f3f5d2e3862fea75e5a62c5f0a68006961fd31ccb658f02fd4ec5d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a882667ad91a210deec5a08d2ae8592f2b317d1e55d5f48cda80f841c5fc84ba"
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
