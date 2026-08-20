class Surge < Formula
  desc "Blazing fast TUI download manager built in Go for power users"
  homepage "https://github.com/SurgeDM/Surge"
  url "https://github.com/SurgeDM/Surge/archive/refs/tags/v0.12.0.tar.gz"
  sha256 "a37f1ff555b1d1027bae6d74b93e2844bc1b68a97134e2b9718bef367618ef42"
  license "MIT"
  head "https://github.com/SurgeDM/Surge.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "614f9366ad7fc883a34a21fdd49e0825a608198c5d43893d5192e5c841c12a88"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "509a098468538265098097ad32777f76d3491edde8c05bc2929a216dede0b01f"
    sha256 cellar: :any,                 x86_64_linux: "d296a90ea689d93e1b0fac114edd0aec36a03262c651066af09c4e20651f4cd8"
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
