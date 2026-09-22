class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://github.com/anomalyco/opencode/archive/refs/tags/v1.18.32.tar.gz"
  sha256 "65e95c9a6666ca65bbd17de1e7cecddac1504e66eeebbcfaf5ac68f97e6f392b"
  license "MIT"
  head "https://github.com/anomalyco/opencode.git", branch: "dev"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:  "75a3274e567b4fb26a04c683b96f05696f81f9abf01f0a95fa79f11d67fe79af"
    sha256                               arm64_linux:  "82ac86ceea1ef12dd5c349eb0f8a5de6f69f278bf4bbecfaf9a204134f2aaf4b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c47bdd3ffa46b80ccdbec0b831ec2df58d2bc1ed26049d9ab349d20e0ae4ec3f"
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
