class ActionsUp < Formula
  desc "Interactive CLI tool to update GitHub Actions"
  homepage "https://github.com/azat-io/actions-up"
  url "https://registry.npmjs.org/actions-up/-/actions-up-1.5.0.tgz"
  sha256 "7beee0eb3bb5dde6878928ee12646a51cb65525ac351f3e483554eda28d59b98"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "fe8a08f9e88d2ad804c5b2a9c05e39c473bfbb2b5868c0576da37f5c7912c209"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6263135c4ed3c252c19690af7243d6087acf16dec23658400a4e87f740d9eaec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5962e2a507475353aa83f2966acca4b6ac10912641663b674caf3b09f5714d8b"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/actions-up --version")
  end
end
