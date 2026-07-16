class CloudflareSpeedCli < Formula
  desc "CLI for internet speed test via cloudflare"
  homepage "https://github.com/kavehtehrani/cloudflare-speed-cli"
  url "https://github.com/kavehtehrani/cloudflare-speed-cli/archive/refs/tags/v1.0.7.tar.gz"
  sha256 "44e8c221ca9c4db39a4f48b81154ba3109ef91307430570727302ea353f50056"
  license "GPL-3.0-only"
  head "https://github.com/kavehtehrani/cloudflare-speed-cli.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "950c4033b835d9912d28777f6677d720a20c72a80483cf9d1f05f4a248dc8934"
    sha256 cellar: :any,                 arm64_linux:  "97669718e9ff30a7fcce3790c411f06af348f0068bc0f4eb6765dd757dea6343"
    sha256 cellar: :any,                 x86_64_linux: "2898fdd611a1eb5ac1f65b346571aabb9e98f3038a3a9b3f5a77751004c3d201"
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
