class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://github.com/anomalyco/opencode/archive/refs/tags/v1.18.20.tar.gz"
  sha256 "10129b7a233d8ea227fe8a65c158d3df4adc3d1296e3af5a136d94080b25a630"
  license "MIT"
  revision 1
  head "https://github.com/anomalyco/opencode.git", branch: "dev"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:  "4d9cbeb975c21f47621a4798655b3aac22729ae596141c21a390969191a1eb32"
    sha256                               arm64_linux:  "161fd5896294e8a3a34f3a5985710d3727d128f7869c85c21342be014fbc7ce4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "340d336645d65eb47d37accd3a92e1eed157ab14dae6e4c07ece83a88745131a"
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
