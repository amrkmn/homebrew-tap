class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://github.com/anomalyco/opencode/archive/refs/tags/v1.19.0.tar.gz"
  sha256 "5dfcfffdf1df64d4a2e8e0e034b5128eb2376cab6d6d34ed808108aac4ce0d78"
  license "MIT"
  head "https://github.com/anomalyco/opencode.git", branch: "dev"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:  "33315c169a8cb704e2a4210d15ed87d68cb540a0325f540a3580e32ea557c076"
    sha256                               arm64_linux:  "f849e91fdbd0b69da3d97ee44cf6a1b775d1c7ee834ee23c9c6cae90d1b4ec55"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2ad2e77c10ede5e7aabfbab0a5a97fa54e3ed38703d974549e022ae7b1548376"
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
