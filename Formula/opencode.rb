class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://github.com/anomalyco/opencode/archive/refs/tags/v1.18.31.tar.gz"
  sha256 "76f69fe27ec2b44e23fa1749029e7c012eb7e975a0f0c7819e9458198dfd3896"
  license "MIT"
  revision 1
  head "https://github.com/anomalyco/opencode.git", branch: "dev"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:  "69e8bd1bccd6e8d1f69b4985b60c381841bc7572df9f44caa72a0f7a839bb3a7"
    sha256                               arm64_linux:  "cd7b2d860bf5a199926e73c81d2b5685d17a373a107356765671cfd3e22a9afa"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c12621818707cef485ed6fe974edfedbabb11026b66f7fa0f992f992def6afbf"
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
