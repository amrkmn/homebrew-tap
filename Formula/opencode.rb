class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.15.28.tgz"
  sha256 "a1162a3d723dbcb8f9353fc8b718bc85d5e255b59493bee4d8035a02f9ab6fb6"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "65b9a757c784900bd80116691b453648a01bbe1320ff0f89dfbe0500342d70b4"
    sha256                               arm64_sequoia: "b647a9dd0497eab1bb4e26b44f451b2cfe3e9231976293df182c25be5ff3e691"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ddd73df1981994748a4b9fac5b1e6b2fe36c5eee77a64ad6347eb8a1dd9dc29a"
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
