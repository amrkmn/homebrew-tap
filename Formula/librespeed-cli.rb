class LibrespeedCli < Formula
  desc "Command-line client for LibreSpeed"
  homepage "https://github.com/librespeed/speedtest-cli"
  url "https://github.com/librespeed/speedtest-cli/archive/refs/tags/v1.0.14.tar.gz"
  sha256 "3031e0f7babd7f9c51a1c49b95026d12532668455e8cc459049160f1bd525bf3"
  license "LGPL-3.0-only"
  head "https://github.com/librespeed/speedtest-cli.git", branch: "master"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a8ff621b999b1b4f5cd85b1dbeb4dc67ff3ab3ba1d17eb495bf5cfc8323d3e93"
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
