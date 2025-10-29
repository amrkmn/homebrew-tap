class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.15.27.tgz"
  sha256 "fea2f9d2d0ec8c531fff4d37b71e256b51fd6372ec00e31ac128c86b56270190"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "c79b2a27b4c69ea78fbc5e3117095ef6260f32574ddc243b7e46b5e495fc2a9e"
    sha256                               arm64_sequoia: "999861f3a8c173f9bb05767241f54b234899c3ad98d960adf552a63d082e7ea1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a2c4b937f41fffa45454ddcf62425468bffbab2a7bed7323e846bdf2df600f8b"
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
