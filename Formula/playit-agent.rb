class PlayitAgent < Formula
  desc "Secure tunnel client to expose local servers via Playit.gg"
  homepage "https://github.com/playit-cloud/playit-agent"
  url "https://github.com/playit-cloud/playit-agent/archive/refs/tags/v0.17.1.tar.gz"
  sha256 "d8c937325d9415d2d73c91b3dda8da3919a5dedf3ea8d831716e00924d32d832"
  license "BSD-2-Clause"
  head "https://github.com/playit-cloud/playit-agent.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "dfc8451f9a310431920a3d29eb46330172fc3e8206bf720b2af40e1fa04a6777"
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
