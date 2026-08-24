class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://github.com/anomalyco/opencode/archive/refs/tags/v1.18.22.tar.gz"
  sha256 "b777d4f92268168b9386b79eca0faa72a92367773fb6d81197cccf886901a3b9"
  license "MIT"
  head "https://github.com/anomalyco/opencode.git", branch: "dev"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:  "8b1edc62fd41c23bfe1255c1095395b3abb66acbe73f0568f7032e0ce3c935a2"
    sha256                               arm64_linux:  "a527148335a977528d37320c854dcf4399c6ef388565e82ba4b4864a51e4650a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "37f8425dd0ba9ef66da5e78deab82b697783c12ac7491548933ac682def30e6f"
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
