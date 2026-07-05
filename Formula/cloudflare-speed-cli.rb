class CloudflareSpeedCli < Formula
  desc "CLI for internet speed test via cloudflare"
  homepage "https://github.com/kavehtehrani/cloudflare-speed-cli"
  url "https://github.com/kavehtehrani/cloudflare-speed-cli/archive/refs/tags/v1.0.6.tar.gz"
  sha256 "5e846dbbc50200fd75542bd68159f322fc2e3b1b7ffa43e4e7c6c8f9b6e4d34e"
  license "GPL-3.0-only"
  head "https://github.com/kavehtehrani/cloudflare-speed-cli.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "718b920b74f28a10727ce60decb271358b152c3e0e52cd2a830850bd2765bdc4"
    sha256 cellar: :any,                 arm64_linux:  "4f9213c54443a47e0cb581b184cc8f87e06e740e8ddbe7a0b3427a7d611d17e0"
    sha256 cellar: :any,                 x86_64_linux: "9c69c9e6faf82465c1ae80c7a5e892e51f30329126f6b4cd4ad081c9b301d140"
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
