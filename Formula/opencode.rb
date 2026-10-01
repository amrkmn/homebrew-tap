class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://github.com/anomalyco/opencode/archive/refs/tags/v1.18.34.tar.gz"
  sha256 "c2c60efde22639b64c7bfa740da39b9c8079391a7540e2f67bf91b36e5797f17"
  license "MIT"
  head "https://github.com/anomalyco/opencode.git", branch: "dev"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:  "b1d449aaff7bd058c791ac9b3b8df91ae8e9a3fe2f193608a78b40ed0d1c430e"
    sha256                               arm64_linux:  "8cb675e3a1420b7ce846cb9067b98e60f20734588cf2fcec82dbd071a5a2227b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "07e02c569abcd7dd273b06dfa5b9cda869871ad0caedc8de6c3b0078c7cbe7de"
  end

  depends_on "bun" => :build
  depends_on "python@3.14" => :build
  depends_on "ripgrep"

  on_linux do
    depends_on "icu4c@78"
  end

  deny_network_access! :test

  def install
    unless build.head?
      ENV["OPENCODE_CHANNEL"] = "prod"
      ENV["OPENCODE_VERSION"] = version.to_s
    end

    # Fix server errors when building with Bun 1.4.2 by disabling splitting
    # https://github.com/anomalyco/opencode/issues/48645
    # https://github.com/NixOS/nixpkgs/issues/563241
    inreplace "packages/opencode/script/build.ts", "splitting: true,", "splitting: false,"

    system "bun", "install", "--frozen-lockfile"

    cd "packages/opencode" do
      baseline = Hardware::CPU.intel? && (!build.head? || !Hardware::CPU.avx2?)
      args = ["run", "./script/build.ts", "--single", "--skip-install"]
      args << "--baseline" if baseline
      system "bun", "--bun", *args

      bin.install Dir["dist/opencode-*/bin/opencode"].find { |p| p.include?("baseline") == baseline }
    end
  end

  test do
    ENV["OPENCODE_DISABLE_MODELS_FETCH"] = "1"

    assert_match version.to_s, shell_output("#{bin}/opencode --version")
    assert_match "opencode", shell_output("#{bin}/opencode models")
  end
end
