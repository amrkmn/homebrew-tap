class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.61.tgz"
  sha256 "25ae98f7d4f752c7ae60c4d3582b74da88a51a557d1ed99afec4555ad79921c1"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "31556efb0a55b441d5b2f4e7f4638135694034a5f80c01ec591feb842fdaf8cb"
    sha256                               arm64_sequoia: "09e580f8023d14e094eadeaca537db14ace3b0e8b68129946dd894c5db79695f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f8da42c14e429c42727e1a65b46574a02ecc9841b23f4792f25ddccf29560003"
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
