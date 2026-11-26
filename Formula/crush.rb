class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.103.0.tgz"
  sha256 "cc4ad85130b8f25387f8261128d0eaa73803b6354a43562b73125c9b221970ed"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    manifest_sha256 "e3cfc58bb1430ec70106d7277103a6858426f67106fe4555fb53569552ba902f"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "b592f5992b30a434dee89dadb59a8624d153940a4f571d37565d3069cdbb275d"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "94479f618f35cb6db44f9c6d3bb4e6d66957c2e56e089daeded845a38731ad04"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1672bf4a2894dc7bfed9175a05029808b92e0a8ce03b0913744b4a8f6e806c51"
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
