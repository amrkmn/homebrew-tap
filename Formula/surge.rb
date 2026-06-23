class Surge < Formula
  desc "Blazing fast TUI download manager built in Go for power users"
  homepage "https://github.com/SurgeDM/Surge"
  url "https://github.com/SurgeDM/Surge/archive/refs/tags/v0.10.0.tar.gz"
  sha256 "c9954a7a055e8b3cca5b6f761b35928a01c42964d01147cb3789d45d34d3763e"
  license "MIT"
  revision 1
  head "https://github.com/SurgeDM/Surge.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "17a850fb416b314c33fd46ef8b9b05e4bd0b2d5a63e70964d40c3c84f4c4ae97"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "c68636e50be4d912153a107e1b91d1ce118346c194cd2d9e7cee6f73294e3a3e"
    sha256 cellar: :any,                 x86_64_linux: "b730edfa5e1266f672faab990ac8573b58a51bb79e2bd8094cc8af1e16a4910d"
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
