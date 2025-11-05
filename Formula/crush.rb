class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.15.1.tgz"
  sha256 "f17ed9bd36dc081708239c00efe5b812aab5ca8833940be5311081ae4d1a1271"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "88befcfcceb001a55baf4cafa487a3120c67557632500b6030a5a78be3b62e5c"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0ff2130a1c177cf92e7e64dd347bd2f467a08b59f10914e85ea13b16345f180c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "279170e3c4a92fbd781015c8323918578e3aee25f879579e9df41bf768330097"
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
