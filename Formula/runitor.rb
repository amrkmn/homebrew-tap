class Runitor < Formula
  desc "Command runner with healthchecks.io integration"
  homepage "https://github.com/bdd/runitor"
  url "https://github.com/bdd/runitor/archive/refs/tags/v1.4.1.tar.gz"
  sha256 "192665c623bc96ed77f122510510c017197e1673ab92bb84546d652afe4416c0"
  license "0BSD"
  revision 2
  head "https://github.com/bdd/runitor.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3a44525fd75b9a9a0b04f88da81869c245e13566317d381b0c6e5332d8207446"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.Version=#{version}"), "./cmd/runitor"
  end

  test do
    output = shell_output("#{bin}/runitor -uuid 00000000-0000-0000-0000-000000000000 true 2>&1")
    assert_match "error response: 400 Bad Request", output
    assert_equal "runitor #{version}", shell_output("#{bin}/runitor -version").strip
  end
end
