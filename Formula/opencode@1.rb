class OpencodeAT1 < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://github.com/anomalyco/opencode/archive/refs/tags/v1.19.4.tar.gz"
  sha256 "2e553ed005b2df4a7efb9edd26db8fc3caafb1b4dfc3c5c3869192334584d8bb"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(1\.\d+\.\d+)$/i)
    strategy :github_releases
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 arm64_tahoe:  "f173821f3cd1ffac1048f9521a6408e73d1ff9b0fe691e2ff855907db013f047"
    sha256 arm64_linux:  "41de67c4a1fb976ae822377cd1d898f08da9784e3e820698163bc0b99e8db5f7"
    sha256 x86_64_linux: "4bdd6e84f6b72558c63af10475dc8bf256fd6e74c341cb100a09525e8ef085de"
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
