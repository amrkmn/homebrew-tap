class PlayitAgent < Formula
  desc "Secure tunnel client to expose local servers via Playit.gg"
  homepage "https://github.com/playit-cloud/playit-agent"
  url "https://github.com/playit-cloud/playit-agent/archive/refs/tags/v0.16.3.tar.gz"
  sha256 "c0c5b9c5b1390a3966badd5d667f66aa5dbf88d360f8b51250ae29ea18f98479"
  license "BSD-2-Clause"
  head "https://github.com/playit-cloud/playit-agent.git", branch: "master"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "packages/agent_cli")

    bin.install_symlink "playit-cli" => "playit"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/playit version")
  end
end
