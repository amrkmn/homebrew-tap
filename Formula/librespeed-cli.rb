class LibrespeedCli < Formula
  desc "Command-line client for LibreSpeed"
  homepage "https://github.com/librespeed/speedtest-cli"
  url "https://github.com/librespeed/speedtest-cli/archive/refs/tags/v1.0.15.tar.gz"
  sha256 "3f7af37e4b3190859fe9438ec35a53708ba40cfb03c4a3fc517d5d6284a97fbd"
  license "LGPL-3.0-only"
  head "https://github.com/librespeed/speedtest-cli.git", branch: "master"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "ba461f1631c4a4521b5c34cd89f7d96a9aad5f95a39becfd10c53b7b840896d6"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "7df576f26555ef2a2170fb20c18b050d478affb85964db84af6f860218e2e883"
    sha256 cellar: :any,                 x86_64_linux: "f949bd8c7bd2c7ee7ef0f4285e6ce5ab4a4de84a09fcc3730bf0c8f3be9c6b3f"
  end

  depends_on "go" => :build

  def install
    defs_path = "github.com/librespeed/speedtest-cli"
    build_date = Time.now.utc.strftime("%Y-%m-%d %H:%M:%S UTC")

    ldflags = %W[
      -s -w
      -X "#{defs_path}/defs.ProgName=#{name}"
      -X "#{defs_path}/defs.ProgVersion=#{version}"
      -X "#{defs_path}/defs.BuildDate=#{build_date}"
    ]

    system "go", "build", *std_go_args(ldflags:)
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/librespeed-cli --version")
  end
end
