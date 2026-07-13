class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://github.com/anomalyco/opencode/archive/refs/tags/v1.17.20.tar.gz"
  sha256 "2a07505ed5f76e84d42f6752594bbbd25ecfe98a82b546b880edb917cfcd239a"
  license "MIT"
  head "https://github.com/anomalyco/opencode.git", branch: "dev"

  livecheck do
    url "https://github.com/anomalyco/opencode/releases/latest/download/latest.json"
    strategy :json do |json|
      json["version"]
    end
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256               arm64_tahoe:  "1e52876769b54f8847271e60ee443b05dbe36dc0e5831cdc6d9d5242cc2a4ca2"
    sha256 cellar: :any, x86_64_linux: "10c9d2078b747cecb906fffa99387a183384fb7e9262bf60392b19ba13fd70e7"
  end

  depends_on "bun" => :build
  depends_on "icu4c@78"
  depends_on "ripgrep"

  def install
    # Bun's isolated linker hits a macOS build failure in v1.17.7.
    # Hoisting keeps the build on the conventional node_modules layout.
    inreplace "bunfig.toml", "exact = true", "exact = true\nlinker = \"hoisted\""

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
