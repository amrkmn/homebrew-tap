class Avr < Formula
  desc "Avrea command-line client"
  homepage "https://avrea.com/"
  url "https://github.com/avrea-com/cli/archive/refs/tags/v0.10.1.tar.gz"
  sha256 "797e7eb791635affdb3d0a2bce686b6739ae0474b86dab4146b7a4789bdcbafc"
  license "Apache-2.0"
  head "https://github.com/avrea-com/cli.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    manifest_sha256 "4a54ad76f87b7711f039cfdb8cdff9d2f9ab5afbe073b6ef0aba99db2ca32823"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "933972e530c0b60e8ff56e913558f592046a2232c9d55dcb4aeba273b10b2b31"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "07717b0d6ef55a74d54b7541dba5e7d202bbf91c8c89ba0c421a2847c14f999f"
    sha256 cellar: :any,                 x86_64_linux: "8e50cffc7245aaae3e052b7b47b7524098920014f09c26cad4a94adef96b0ad3"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -X main.version=#{version}
      -X main.commit=homebrew
    ]
    system "go", "build", *std_go_args(ldflags:), "./cmd/avr"

    generate_completions_from_executable(bin/"avr", shell_parameter_format: :click)
    man1.install Dir["man/man1/*.1"]
    bin.install_symlink bin/"avr" => "avr-cli"
  end

  test do
    assert_match "avr version #{version}", shell_output("#{bin}/avr --version")
    assert_match "avr version #{version}", shell_output("#{bin}/avr-cli --version")
    assert_match "Avrea on the command line.", shell_output("#{bin}/avr --help")
    assert_match "USAGE\n  avr", shell_output("#{bin}/avr --help")
  end
end
