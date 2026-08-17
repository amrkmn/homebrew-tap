class LibrespeedCli < Formula
  desc "Command-line client for LibreSpeed"
  homepage "https://github.com/librespeed/speedtest-cli"
  url "https://github.com/librespeed/speedtest-cli/archive/refs/tags/v1.0.14.tar.gz"
  sha256 "3031e0f7babd7f9c51a1c49b95026d12532668455e8cc459049160f1bd525bf3"
  license "LGPL-3.0-only"
  head "https://github.com/librespeed/speedtest-cli.git", branch: "master"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "979320d527da23152177ef058c976cdf097f39e019e2a47a8342c4e195ae407a"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "8bdf409f7a41091cdc9a6a8ddc72f8bfe3dcf7fa429864290366e07f627560e0"
    sha256 cellar: :any,                 x86_64_linux: "bdaa79fe80152defdd0116fd98804dbbb905cdaa37f10e53970664b811222681"
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
