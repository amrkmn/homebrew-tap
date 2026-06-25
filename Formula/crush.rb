class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.80.0.tgz"
  sha256 "cc8ba3a299ea192b9815f9be53c91ed99c86589c9f1bc137b97e4a8e4d3cf5f2"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "a0643a020dfd0fdcc092fcbedfcc716e08604cd2449cc2ed0d5d7099d3e52545"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "570a46f06b7f2ca34f822fcba10f17bfe7d943f7e6ed49e3cd6ae58bc94aefc2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6792b8f176103a464a979d265171374ff4796cdda5fdd80169cecac088e0d86f"
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
