class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://github.com/anomalyco/opencode/archive/refs/tags/v1.18.29.tar.gz"
  sha256 "8fd2a4e179a6a001e68f1f0986e6687be524a9a28239b8997c6b7e9a72033231"
  license "MIT"
  head "https://github.com/anomalyco/opencode.git", branch: "dev"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:  "286621f3caa9a9446eeaf2136b98ac4bcff2b57c15f5608a5ff43e2bbba4a326"
    sha256                               arm64_linux:  "feb4b9d67b3d67da0234e499341094096ace1f8944912f9da806c1458face7de"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7d4c3bcff62f99473ce8e0c551257a21a28d957f03d5da09258212f605fd916c"
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
