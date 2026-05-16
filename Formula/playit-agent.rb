class PlayitAgent < Formula
  desc "Secure tunnel client to expose local servers via Playit.gg"
  homepage "https://github.com/playit-cloud/playit-agent"
  url "https://github.com/playit-cloud/playit-agent/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "396f0c10753640a35a3d7db1aed9884ce138af445175243b942235faa0fd4cd1"
  license "BSD-2-Clause"
  head "https://github.com/playit-cloud/playit-agent.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "311fca726369d4e633284963c9ec648a182aafa3c7bcb35fb3469122c3a84adb"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "packages/playit-cli")
    bin.install_symlink "playit-cli" => "playit"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/playit version")
  end
end
