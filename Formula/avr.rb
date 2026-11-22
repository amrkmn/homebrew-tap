class Avr < Formula
  desc "Avrea command-line client"
  homepage "https://avrea.com/"
  url "https://github.com/avrea-com/cli/archive/refs/tags/v0.10.1.tar.gz"
  sha256 "797e7eb791635affdb3d0a2bce686b6739ae0474b86dab4146b7a4789bdcbafc"
  license "Apache-2.0"
  head "https://github.com/avrea-com/cli.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "b982156317078e21c1c4c5852d0cc16df9166228ce27d97ef3b6ea6893b754c3"
    sha256 cellar: :any,                 arm64_linux:  "bf3dccd23de98d006be5cd66c62e3b16e074a2265c106be9c52f05556b36fea3"
    sha256 cellar: :any,                 x86_64_linux: "03045466868e076079d4814c1738197c9202b82ce478256fb2b9d31777fbb4bf"
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
