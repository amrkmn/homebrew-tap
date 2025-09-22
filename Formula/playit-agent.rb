class PlayitAgent < Formula
  desc "Secure tunnel client to expose local servers via Playit.gg"
  homepage "https://github.com/playit-cloud/playit-agent"
  url "https://github.com/playit-cloud/playit-agent/archive/refs/tags/v0.16.3.tar.gz"
  sha256 "c0c5b9c5b1390a3966badd5d667f66aa5dbf88d360f8b51250ae29ea18f98479"
  license "BSD-2-Clause"
  head "https://github.com/playit-cloud/playit-agent.git", branch: "master"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "cf38660fc157db0caf428656b5f7b6d8ee0f39c7b5b2d2e029972bc9a331c7f9"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "bdbf588dfddcaad1659272ee98fc58dacbde387a164519bd1da08b173e3d179c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5cde4f05f2c15d2479f1f2d6fd96d7b6504bb4907440e2a0ac31c00df02e91b9"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "packages/agent_cli")

    bin.install_symlink "playit-cli" => "playit"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/playit version")
  end
end
