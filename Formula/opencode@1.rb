class OpencodeAT1 < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://github.com/anomalyco/opencode/archive/refs/tags/v1.19.5.tar.gz"
  sha256 "7d2ac43b5083a3a4687fe23b79ab153b8d93a6fb186fa07209ed28d4731e5c7a"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(1\.\d+\.\d+)$/i)
    strategy :github_releases
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 arm64_tahoe:  "7d94ba1f3988059818389cd266e49c8b9db9d4bfc9e482c00bf83e23592fee51"
    sha256 arm64_linux:  "03c6956ca922ec5c9ea1298b7ff400bf2a9b830d04234ae4728e4fa660921ac2"
    sha256 x86_64_linux: "2ace67404f5ff81c9f6a7661f54f7f5d65c28f88285808014069a1f0213de539"
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
