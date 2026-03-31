class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://github.com/anomalyco/opencode/archive/refs/tags/v1.3.9.tar.gz"
  sha256 "99a3a3a7ac64a62b41df34e6b2f4aee75a04882932f6a6b4545a79d3e584a840"
  license "MIT"
  head "https://github.com/anomalyco/opencode.git", branch: "dev"

  livecheck do
    url "https://github.com/anomalyco/opencode/releases/latest/download/latest.json"
    strategy :json do |json|
      json["version"]
    end
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a8f15115a5213b1940a738f7a368d66d7dde5c0ed09f5ab22ec513a3455f2e51"
  end

  depends_on "amrkmn/bun/bun" => :build
  depends_on "ripgrep"

  def install
    system "bun", "install"
    cd "packages/opencode" do
      ENV["OPENCODE_CHANNEL"] = build.head? ? "canary" : "latest"
      ENV["OPENCODE_VERSION"] = build.head? ? "canary-#{version.commit}" : version.to_s
      system "bun", "run", "./script/build.ts", "--single"

      arch = Hardware::CPU.arm? ? "arm64" : "x64"
      os = OS.linux? ? "linux" : "darwin"
      suffix = (build.head? && !Hardware::CPU.avx2?) ? "-baseline" : ""
      target_dir = "opencode-#{os}-#{arch}#{suffix}"

      rm_r Dir["dist/*"].reject { |dir| File.basename(dir) == target_dir }
      bin.install "dist/#{target_dir}/bin/opencode"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/opencode --version")
    assert_match "opencode", shell_output("#{bin}/opencode models")
  end
end
