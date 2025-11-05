class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.28.tgz"
  sha256 "59eecb8cd32aebb6f21fe28f1e3134c962f27c52424222eeb01801f09f428723"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "ef5673b7bdcb80de29e565ee9155d9d0e2609c9c618b300c297436ac4bf6503c"
    sha256                               arm64_sequoia: "adba4b6a2ef01eb55cedd77246d66c97a9a6c610260e515873addb3916a05924"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5a8d898cc9ef5ef9c165d56233d666fdde85fc774388f1d0bd9740a791392cc6"
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
