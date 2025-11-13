class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.18.0.tgz"
  sha256 "f804b4fd0daeff54782f7b5839b7b6216bffc9561f1dcbe6b83304e2df9eb741"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "352ca53c9c46d5c720157c02aeab5184b51e366bddc728aa613063e8ef1838f5"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2aad746ae93e96fac885916ba6920c289d2c5ed401a2b58790c99ec614b86633"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "266933caf28c767d63de9fd2a60a5063bb44c49c26cc184cf00aac384079f77b"
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
