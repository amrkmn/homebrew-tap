class Surge < Formula
  desc "Blazing fast TUI download manager built in Go for power users"
  homepage "https://github.com/SurgeDM/Surge"
  url "https://github.com/SurgeDM/Surge/archive/refs/tags/v0.12.2.tar.gz"
  sha256 "bcd281be8e304b10a55a729756a262d2693f5dad56cd29d573815ce8eb9c49d3"
  license "MIT"
  head "https://github.com/SurgeDM/Surge.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "887cdad38b4c3ea5f9739cee6ca505e9594a5b64c7283324aafb5682b9cedbb3"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "b9bcf61c34a17dec4e422bcbfe17973c012ccac805ff8ee4e2954071ae6077bc"
    sha256 cellar: :any,                 x86_64_linux: "7502ec4aa936406c24e27d9c284350989b5202e10c2aa904f8fd8868ed4ea604"
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
