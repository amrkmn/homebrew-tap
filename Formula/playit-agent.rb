class PlayitAgent < Formula
  desc "Secure tunnel client to expose local servers via Playit.gg"
  homepage "https://github.com/playit-cloud/playit-agent"
  url "https://github.com/playit-cloud/playit-agent/archive/refs/tags/v0.16.3.tar.gz"
  sha256 "c0c5b9c5b1390a3966badd5d667f66aa5dbf88d360f8b51250ae29ea18f98479"
  license "BSD-2-Clause"
  head "https://github.com/playit-cloud/playit-agent.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "8dd427c9da93ed3190ff2e6ca0b27d8f8298e1bf883710c904bbde007c2856dc"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b6095e6b435091f949b63559e6c01d9392e1ee7477aa2f6ea76e39d516aa0892"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bd6583ef544a443b87aadb9355bf9e8acd3cccdbd5459e3bb067a969763715a9"
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
