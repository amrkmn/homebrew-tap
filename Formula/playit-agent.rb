class PlayitAgent < Formula
  desc "Secure tunnel client to expose local servers via Playit.gg"
  homepage "https://github.com/playit-cloud/playit-agent"
  url "https://github.com/playit-cloud/playit-agent/archive/refs/tags/v0.16.4.tar.gz"
  sha256 "8e7092a2c35982116f490b12d7c2e65f42dc0bf74d2475a223f2114e05199afd"
  license "BSD-2-Clause"
  head "https://github.com/playit-cloud/playit-agent.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "0976b1c22abf115bf0add04996e4be6ea74a963d6b1bc9b05031f5a4a71f0c4e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c72606e6463ca52e97846bd92c82306a3b6f5425fe4bdae4e4f472c288b96a1f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2d6c83f9e095263548b2fbbe94b5a21a5c7816797b5cba36a07b9c689e6bceab"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "packages/agent_cli")
    mv bin/"playit-cli", bin/"playit"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/playit version")
  end
end
