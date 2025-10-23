class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.12.2.tgz"
  sha256 "775118d438c13182ffea1ecf5c6a6aa121a65614a53056c45e871ee95a9c0aa5"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "2e908b696c6118441efa9b40272cb08bca1875558ba54961993d3bdaf06d8d48"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "cf956642932936f1876fd3ab27bad206d4e66c130d04219a6fd378e8252e9c43"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fcd546d0d3a8c2455bfc589015de07395affc5a5d9276ad4e00ff81763571e0e"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]

    generate_completions_from_executable(bin/"crush", "completion")
  end

  test do
    assert_match "crush version v#{version}", shell_output("#{bin}/crush --version")
  end
end
