class Surge < Formula
  desc "Blazing fast TUI download manager built in Go for power users"
  homepage "https://github.com/SurgeDM/Surge"
  url "https://github.com/SurgeDM/Surge/archive/refs/tags/v0.12.4.tar.gz"
  sha256 "97d34131f6a0aba56a048e45bb7a5162558bb38ae37c9f0f8ee6d09e5b0b14f6"
  license "MIT"
  head "https://github.com/SurgeDM/Surge.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "7e6db67b7f11e141b9f2fe8d7a2b337c6831b415c6afb9a2ac164b703cf6172b"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "0a10cacd3d9d5032f0190fc5ccbb44b81e6b18ccb34acb0147d92c2d4a0646db"
    sha256 cellar: :any,                 x86_64_linux: "a0e8602d97dc2fd4d4d1e6082f05b3c095549077b9b783fc652a7c240c39de42"
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
