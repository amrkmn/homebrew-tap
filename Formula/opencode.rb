class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://github.com/anomalyco/opencode/archive/refs/tags/v1.18.28.tar.gz"
  sha256 "8eea501a6a00cbebe524af7c3248c0bfc56290f444671903e32aa6b799ee6616"
  license "MIT"
  head "https://github.com/anomalyco/opencode.git", branch: "dev"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:  "4237b931e3e8265d42bd58562b618c3251cff3a55e2162ec5c675b3e6f1f2731"
    sha256                               arm64_linux:  "905c274ebe19cbf990c3405cf614a9c083c02d01fc354844d0e5dfc4a28e9dc4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "435f36dbdf0d172d96146ec1621fa3ce919657b3e6ee4382ed8cfbb83e971424"
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
