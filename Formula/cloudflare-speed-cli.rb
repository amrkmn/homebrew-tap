class CloudflareSpeedCli < Formula
  desc "CLI for internet speed test via cloudflare"
  homepage "https://github.com/kavehtehrani/cloudflare-speed-cli"
  url "https://github.com/kavehtehrani/cloudflare-speed-cli/archive/refs/tags/v1.0.9.tar.gz"
  sha256 "bf54d0e8d89262d50b777a5bf2f545a333107e85fc9e634bba366d62194448b4"
  license "GPL-3.0-only"
  head "https://github.com/kavehtehrani/cloudflare-speed-cli.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "e6af2ea9e8155d6f7d3e21809586c248ea714d7f29745d41b4c58eb180f75572"
    sha256 cellar: :any,                 arm64_linux:  "f96b9a129ebbe423d067c64f24af7876eb97c02262b8af753a5ffc6f12bb8bce"
    sha256 cellar: :any,                 x86_64_linux: "9a2a26b3299a3bc25c6803ef219c765b4acbae4a0514ad9e581c05357dd9742b"
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
