class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.18.3.tgz"
  sha256 "70434ec4168a354de9b1973fee129e83e49019418a2e1a757dd8892df93f610d"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "6b8f2495cf784ac6be42100a2a4ac01a1cf6856deb2b35405ee35cdc8925aafd"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8788a1b0b659b0cb8fb33651d4954f6633f61b9b7476dbdf874bf4a51cddd9b2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f707d1fe53377f84c4707f4d573fd6e0d611eb2fb191200b6cfac4d83e186f0b"
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
