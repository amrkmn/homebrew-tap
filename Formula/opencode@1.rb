class OpencodeAT1 < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://github.com/anomalyco/opencode/archive/refs/tags/v1.19.4.tar.gz"
  sha256 "2e553ed005b2df4a7efb9edd26db8fc3caafb1b4dfc3c5c3869192334584d8bb"
  license "MIT"
  revision 1

  livecheck do
    url :stable
    regex(/^v?(1\.\d+\.\d+)$/i)
    strategy :github_releases
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 arm64_tahoe:  "a7caab9c43a5d1584d530e82b2d80a9f92b89cd91d2e5a95d1494cbf744d1c3d"
    sha256 arm64_linux:  "8f6be7413e09f47b240699fc35841cb48b1f2f3fd44bf013ee5866b5b1da58a1"
    sha256 x86_64_linux: "e46ce96f8154f14c108ce01a142f16aa2d84ec096c16cdcfb985676f60752f45"
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
