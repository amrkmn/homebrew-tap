class CloudflareSpeedCli < Formula
  desc "CLI for internet speed test via cloudflare"
  homepage "https://github.com/kavehtehrani/cloudflare-speed-cli"
  url "https://github.com/kavehtehrani/cloudflare-speed-cli/archive/refs/tags/v1.0.11.tar.gz"
  sha256 "6d0562e84220c13e21b46d1ef78e2686b41ff73f20da484eeb588080e28fc1ae"
  license "GPL-3.0-only"
  head "https://github.com/kavehtehrani/cloudflare-speed-cli.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "1f9f6445345010fdead3c174d16290c211518b5f67b3b00baa30ca64d4ae185c"
    sha256 cellar: :any,                 arm64_linux:  "caf7e6b5e7a6e4b350dffb5fc5ab35759843632f8ced8f63c66ad052871baccd"
    sha256 cellar: :any,                 x86_64_linux: "16c78a5b1dc8a73ffe9a16016d01d21b8ec6be6cbe2e60478ec5df7986c9f81f"
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
