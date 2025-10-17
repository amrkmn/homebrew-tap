class ActionsUp < Formula
  desc "Interactive CLI tool to update GitHub Actions"
  homepage "https://github.com/azat-io/actions-up"
  url "https://registry.npmjs.org/actions-up/-/actions-up-1.4.2.tgz"
  sha256 "4ee181ad3eb8eda9ca4543ce6ba1244453ee4888bab7aefbe11d6b06b93d8708"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "73e90306746c8aae27918bdb99fb81d07698b17c572d6337d2ae20daf06c6ce0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "704df7b50a62091a5fa8fca453d9b6fb0f7fe2e49323969ac20c7a751e19fd81"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "dd5314e43e0f63e87329c7e240606312e11bc888e86ab7003220cb200273ca87"
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
