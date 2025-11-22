class LibrespeedCli < Formula
  desc "Command-line client for LibreSpeed"
  homepage "https://github.com/librespeed/speedtest-cli"
  url "https://github.com/librespeed/speedtest-cli/archive/refs/tags/v1.0.12.tar.gz"
  sha256 "2813ff49a8bc99687e70599212e05f0d995cd7f685e1202e80eea4ff58767301"
  license "LGPL-3.0-only"
  head "https://github.com/librespeed/speedtest-cli.git", branch: "master"

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
