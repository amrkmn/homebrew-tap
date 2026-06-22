class Surge < Formula
  desc "Blazing fast TUI download manager built in Go for power users"
  homepage "https://github.com/SurgeDM/Surge"
  url "https://github.com/SurgeDM/Surge/archive/refs/tags/v0.10.0.tar.gz"
  sha256 "c9954a7a055e8b3cca5b6f761b35928a01c42964d01147cb3789d45d34d3763e"
  license "MIT"
  revision 1
  head "https://github.com/SurgeDM/Surge.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "61cb4122c32e155f2bb82a0fc34db4fe0d766c24118e254634bfe1e152b09726"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "8660ae7d3ddee33b66311ba2a8c854a96a3b87f8eb2f8376395f2cd8e5f47f07"
    sha256 cellar: :any,                 x86_64_linux: "b2590b9717ad49a2c9a399941d367a5b6ff380aab8c7778fc1501ced96936899"
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
