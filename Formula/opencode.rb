class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.14.5.tgz"
  sha256 "2e841be1821ccd2f8c18a5792da6f823ee0d6041ea95815ab11bc2a1f3817174"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "383feab5519b39f066b1121f8c0434dca8d43f5f780fabb317652d3389256a29"
    sha256                               arm64_sequoia: "e51126af962466f658062bfe7b45a122a91d37d6de0587d002ebc74e918fdd25"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e9bf464a03e3db5aa214645cb4ea3d20d141393c67b25d28dd92160be17011b7"
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
