class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://github.com/anomalyco/opencode/archive/refs/tags/v1.18.23.tar.gz"
  sha256 "7b621e56e9e9162464f2524d88810f8e0e0036cf29cdadb35c574384eba3e6cf"
  license "MIT"
  head "https://github.com/anomalyco/opencode.git", branch: "dev"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:  "075243bc632652b2cceb2c631deaf90d0aae0527a709d78453283cbaff7e6bcb"
    sha256                               arm64_linux:  "dfbe60db4b7efd6c8805e03357dba78053cec63b1957272be86a3fd40a05ef4b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "575ef32cc06f1c0f2876bf4f98254a8e84e978300388be3b0356e3899ceaa388"
  end

  depends_on "bun" => :build
  depends_on "ripgrep"

  on_linux do
    depends_on "icu4c@78"
  end

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
