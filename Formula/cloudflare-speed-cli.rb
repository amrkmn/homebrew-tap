class CloudflareSpeedCli < Formula
  desc "CLI for internet speed test via cloudflare"
  homepage "https://github.com/kavehtehrani/cloudflare-speed-cli"
  url "https://github.com/kavehtehrani/cloudflare-speed-cli/archive/refs/tags/v1.0.12.tar.gz"
  sha256 "4a873aa6fe7fd66ac47df3b0a34038771b4a17b11e0894c69263138fc73208c7"
  license "GPL-3.0-only"
  head "https://github.com/kavehtehrani/cloudflare-speed-cli.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "76b6dcaa4810c0b7b5b67b36a3f2b9c8985268b5f0a55a60b4d17e42989bc9ae"
    sha256 cellar: :any,                 arm64_linux:  "e871ea2052e9f868eea3e031a696b9a1f48492503d4ed87854bbd29878d4228d"
    sha256 cellar: :any,                 x86_64_linux: "9affe6c8dca185a4dc278ec0e9b92d67157d38ff23d85a57fbee03fcc07733f5"
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
