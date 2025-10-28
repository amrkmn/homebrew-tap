class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.13.3.tgz"
  sha256 "4714cb849e2024de39846d206f3fe9cfd5654715b40ef7686ffe32d54222353e"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "b591df4e7fc2cf1c5a41f7c6643a5ab55b565cc8f86c9bba582bf688b21666f5"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "459d328851a85af2e6cabc92548b95bfa2ceeb4bc2c06f11a6699961899ae82d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "68fbdf4ef3620362b407ca89dba227be26264f665b0a6bd4327caea506601e23"
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
