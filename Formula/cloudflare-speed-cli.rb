class CloudflareSpeedCli < Formula
  desc "CLI for internet speed test via cloudflare"
  homepage "https://github.com/kavehtehrani/cloudflare-speed-cli"
  url "https://github.com/kavehtehrani/cloudflare-speed-cli/archive/refs/tags/v1.0.11.tar.gz"
  sha256 "6d0562e84220c13e21b46d1ef78e2686b41ff73f20da484eeb588080e28fc1ae"
  license "GPL-3.0-only"
  head "https://github.com/kavehtehrani/cloudflare-speed-cli.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "d6d233a7081a9f5da55bcb690a6298aa0b8e94136661e69f37a78b492dd038a4"
    sha256 cellar: :any,                 arm64_linux:  "b5cf14d16db1c9d1d12f0d4c65a6b3e4ea0cae7a36c2195fe83ea2314a483b30"
    sha256 cellar: :any,                 x86_64_linux: "a5f65805e965de2775f6d7d7e1f78c052d48dcc95203cd79b25561b5604d4c85"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cloudflare-speed-cli --version")

    output = shell_output("#{bin}/cloudflare-speed-cli --json --skip-diagnostics " \
                          "--auto-save false --download-duration 1s --upload-duration 1s")
    assert_equal "https://speed.cloudflare.com", JSON.parse(output)["base_url"]
  end
end
