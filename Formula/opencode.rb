class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://github.com/anomalyco/opencode/archive/refs/tags/v1.17.16.tar.gz"
  sha256 "1b4d6708a7b5a7f21b8a9448a3d80be963d61605b25a3194f5620828dffb51fc"
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
    sha256               arm64_tahoe:  "90fd54355bea7bec7c01a9dfd4bbd1a3e6452157ecc01d36daa1b82b719114f8"
    sha256 cellar: :any, x86_64_linux: "d66d51fb7c1aa578a6787d4374d6408b146ed94759b9e2b928738c9235957ec3"
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
