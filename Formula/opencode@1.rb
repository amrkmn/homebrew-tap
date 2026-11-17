class OpencodeAT1 < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://github.com/anomalyco/opencode/archive/refs/tags/v1.19.6.tar.gz"
  sha256 "0dfc7c58a82a1f9ca635ebcfe8aad594009edb22a5ef752719d2b89fbe5918b8"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(1\.\d+\.\d+)$/i)
    strategy :github_releases
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 arm64_tahoe:  "da5034272ca9022e8ba471a9d1a4db3b8e1b87fd34dbf11b2b7bfce70cea5518"
    sha256 arm64_linux:  "928387adad5e2e9f22f476a03c454ed5f7027614657a7f2809ecc8d02f039b3f"
    sha256 x86_64_linux: "9bc88e52d98cc3d6dcee0aa9813c468fb3bff9ac933ab586eae63f447115cb1a"
  end

  keg_only :versioned_formula

  depends_on "bun" => :build
  depends_on "python@3.15" => :build
  depends_on "ripgrep"

  on_linux do
    depends_on "icu4c@79"
  end

  deny_network_access! :test

  def install
    ENV["OPENCODE_CHANNEL"] = "prod"
    ENV["OPENCODE_VERSION"] = version.to_s

    # Fix server errors when building with Bun 1.4.2 by disabling splitting
    # https://github.com/anomalyco/opencode/issues/48645
    # https://github.com/NixOS/nixpkgs/issues/563241
    inreplace "packages/opencode/script/build.ts", "splitting: true,", "splitting: false,"

    system "bun", "install", "--frozen-lockfile"

    cd "packages/opencode" do
      system "bun", "--bun", "./script/build.ts", "--single", "--skip-install"
      bin.install Pathname.pwd.glob("dist/opencode-*/bin/opencode").first
    end

    generate_completions_from_executable(bin/"opencode", "completion", shell_parameter_format: :none, shells: [:zsh])
  end

  test do
    ENV["OPENCODE_DISABLE_MODELS_FETCH"] = "1"

    assert_match version.to_s, shell_output("#{bin}/opencode --version")
    assert_match "opencode", shell_output("#{bin}/opencode models")
  end
end
