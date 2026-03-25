class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://github.com/anomalyco/opencode/archive/refs/tags/v1.3.2.tar.gz"
  sha256 "5d1ed603b3e236a83cb5386d7c1a268da374abb238867f545e21cc6eb2f32149"
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
    sha256 cellar: :any_skip_relocation, x86_64_linux: "24f482526172d7f618f42189c22ceb24ee516c30cda808bf9556d17fe1d8fbfa"
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
