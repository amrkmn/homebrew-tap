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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "96ac40c8c904096a8ffa0fb6bc4ab4eb76c985a8e947b8f1c82fec5bf70888aa"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "6aab8a9ec6886afc29a39ac5dfdf07ab6cf166f702e4ff7bb6d282f387525b1f"
    sha256 cellar: :any,                 x86_64_linux: "3802d4197def5d2c820b58c708ee4fcc2174a9413733848f5a3ba1c1395ddbf2"
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
