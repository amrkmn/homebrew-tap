class LibrespeedCli < Formula
  desc "Command-line client for LibreSpeed"
  homepage "https://github.com/librespeed/speedtest-cli"
  url "https://github.com/librespeed/speedtest-cli/archive/refs/tags/v1.0.12.tar.gz"
  sha256 "2813ff49a8bc99687e70599212e05f0d995cd7f685e1202e80eea4ff58767301"
  license "LGPL-3.0-only"
  head "https://github.com/librespeed/speedtest-cli.git", branch: "master"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "6e262800dda51666d982b5656f93b5fc37101c7ae99cd84c0c5707aaebfb5004"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "12af3ed15247637dfc63ea2bdbe5d8d41d195ebac115bad48ca8bb8ffe07f8ad"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4290fca2cc10daaa346a7a002b5202d42c10ea7dba9071a9853af2d79c0be43a"
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
