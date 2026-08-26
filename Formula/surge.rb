class Surge < Formula
  desc "Blazing fast TUI download manager built in Go for power users"
  homepage "https://github.com/SurgeDM/Surge"
  url "https://github.com/SurgeDM/Surge/archive/refs/tags/v0.12.1.tar.gz"
  sha256 "4c12d476211c9c5c1e950456b57c0031ef51751ee6c859350777c62604f57a14"
  license "MIT"
  head "https://github.com/SurgeDM/Surge.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "2b141f3200bda13356df888c57dd7634217550d216426bfbf07ceaee96b27b25"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "3c7617d884d01491cef47ad55b4f5da7e69476111ea898047d2fb6fe97cec2eb"
    sha256 cellar: :any,                 x86_64_linux: "8cb8607808bc1a6834e2d66b4ea3bd853d86a2b316afe6692ab7765a3e24b480"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/SurgeDM/Surge/cmd.Version=#{version}
    ]
    system "go", "build", *std_go_args(ldflags:)
  end

  test do
    ENV["HOME"] = testpath

    assert_match "v#{version}", shell_output("#{bin}/surge --version")
    assert_match "TUI download manager", shell_output("#{bin}/surge --help")
    assert_match "NOT running", shell_output("#{bin}/surge server status")
    assert_match "No downloads found", shell_output("#{bin}/surge ls")
  end
end
