class Surge < Formula
  desc "Blazing fast TUI download manager built in Go for power users"
  homepage "https://github.com/SurgeDM/Surge"
  url "https://github.com/SurgeDM/Surge/archive/refs/tags/v0.13.0.tar.gz"
  sha256 "9e45f2004171578658e1d31524128966727b3a4c5fec8a1f9b1677648643e022"
  license "MIT"
  head "https://github.com/SurgeDM/Surge.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    manifest_sha256 "98e506230997f38fdbf169192a0c5c288586f37eb9e2a65936fe7a80409dab71"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "c7b674bf5bb11347ecad78d97dd5d6b0ab43ae2de6faeb48082a9bb140c9f82e"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "4b648fc24c9fda16760eda28572860765282dbd002c4d0213285211d13e0c589"
    sha256 cellar: :any,                 x86_64_linux: "f6b3bd9d5df801041a466b4d96d5469caf37a6b351a8bd1dddf5e9f00c430c45"
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
