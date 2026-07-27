class CloudflareSpeedCli < Formula
  desc "CLI for internet speed test via cloudflare"
  homepage "https://github.com/kavehtehrani/cloudflare-speed-cli"
  url "https://github.com/kavehtehrani/cloudflare-speed-cli/archive/refs/tags/v1.0.8.tar.gz"
  sha256 "a510b28d7b70b5e5ca6e55c64e3342f938990a211f5ed91f4281c15464dfaa24"
  license "GPL-3.0-only"
  head "https://github.com/kavehtehrani/cloudflare-speed-cli.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "c6828e041b95959eef2c7fafc14f493a5f72149ec4d89f6d0f8a42a907087bf8"
    sha256 cellar: :any,                 arm64_linux:  "38d522219f70147f8be2094ac4387d8018d0687161e21ed98b4422b331233610"
    sha256 cellar: :any,                 x86_64_linux: "dca88e31dfd1938f564e62806e6ba18f3c0007c032fcd5f93aa4d2134aeba757"
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
