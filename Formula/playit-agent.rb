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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "c450649f56f2375e3e5cae0ef705db259c214528ac6d293d7b01b41f6c766b3d"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8e5d780668ebfb57bd346bba3ff0997c9214bcb13adee01e82f3b2b0c62402fc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2cff55a46fb0391e6be6cf4f1a621a3f40db53560f607e238fa9c387b442404b"
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
