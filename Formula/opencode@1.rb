class OpencodeAT1 < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://github.com/anomalyco/opencode/archive/refs/tags/v1.19.1.tar.gz"
  sha256 "d96b32749ab8e96fa553086d9d03c0356022a3af312911ed065bd69f22c261be"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(1\.\d+\.\d+)$/i)
    strategy :github_releases
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 arm64_tahoe:  "128aa284b8697a9a3848004bdfe7521b9e48f32ddcef70361647d7d9a36e83ff"
    sha256 arm64_linux:  "0704dcf49146487704ed223d6d14f8efc8eb0299121ee5fdbcf1e7de5f939329"
    sha256 x86_64_linux: "e036205305628035c3e168981e6089cfcae3e20ea6f07f4198c40ff57bfda001"
  end

  keg_only :versioned_formula

  depends_on "bun" => :build
  depends_on "python@3.14" => :build
  depends_on "ripgrep"

  on_linux do
    depends_on "icu4c@78"
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
