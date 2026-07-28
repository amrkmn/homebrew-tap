class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://github.com/anomalyco/opencode/archive/refs/tags/v1.18.8.tar.gz"
  sha256 "1a998288639d9e8d5df4b6ad37762b9ccacac9f18d95651071e51fa97c76c720"
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
    sha256               arm64_tahoe:  "519647ef76b22b328c0c89755206f0c71f8ef3d14a4fc4a7e67c048226146e90"
    sha256 cellar: :any, x86_64_linux: "ec0c3c636176263f2adf5ed1e12dea49a0f043e16c8621ac1fc1cc56ef900f3a"
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
