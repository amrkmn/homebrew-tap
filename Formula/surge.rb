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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "74bbdb0b16b3dd758ec125b880222da3561b731b66d766d93ef262ca314667f3"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "2265a0dc930e488ca517096d17922dbc9c4d951324b1a1020269e85b2362bd4d"
    sha256 cellar: :any,                 x86_64_linux: "d70ac669e68c2740a47515d8abe74fd0c11b281a32a2be5cc8cdb0d4bfd5285a"
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
