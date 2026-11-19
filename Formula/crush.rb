class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.102.0.tgz"
  sha256 "8268f5a11823692207a0d6030dfa17d90cdcdb189f56e83a516071d49b7e9a16"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "8a072306330a995b58c273a9580067aaef0441562bbb70fa157860f250ff1ad8"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "72be87ef9146f2c347c83042dff74d2e8afa1d1eb01306c7ef6b5fe03da7812d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5dd7c9dc18a12459e1ee50fb6af3cad89731160b43219bf0fa7db0c697ee63ee"
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
