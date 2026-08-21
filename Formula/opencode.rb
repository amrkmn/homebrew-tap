class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://github.com/anomalyco/opencode/archive/refs/tags/v1.18.20.tar.gz"
  sha256 "10129b7a233d8ea227fe8a65c158d3df4adc3d1296e3af5a136d94080b25a630"
  license "MIT"
  revision 1
  head "https://github.com/anomalyco/opencode.git", branch: "dev"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:  "ca2554f93bd1cbb9f3896221d1f06effef22cd9772765e108d9d2c788ec720ba"
    sha256                               arm64_linux:  "a69822c4c1da955714981bac72e5ec6f26ebc1358ad12ec01424c3215c298ad1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3a6c6d3c81b2d8bd1423b0f8edd78d9447503095be24c8ccf1e901ae16c760d7"
  end

  depends_on "bun" => :build
  depends_on "ripgrep"

  def install
    system "bun", "install", *(build.head? ? [] : ["--frozen-lockfile"])

    cd "packages/opencode" do
      unless build.head?
        ENV["OPENCODE_CHANNEL"] = "latest"
        ENV["OPENCODE_VERSION"] = version.to_s
      end

      build_baseline = Hardware::CPU.intel? && (!build.head? || !Hardware::CPU.avx2?)
      build_args = ["run", "./script/build.ts", "--single"]
      build_args << "--baseline" if build_baseline
      system "bun", *build_args

      arch = Hardware::CPU.arm? ? "arm64" : "x64"
      os = OS.linux? ? "linux" : "darwin"
      suffix = build_baseline ? "-baseline" : ""

      bin.install "dist/opencode-#{os}-#{arch}#{suffix}/bin/opencode"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/opencode --version")
    assert_match "Commands:", shell_output("#{bin}/opencode --help 2>&1")
  end
end
