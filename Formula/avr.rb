class Avr < Formula
  desc "Avrea command-line client"
  homepage "https://avrea.com/"
  url "https://github.com/avrea-com/cli/archive/refs/tags/v0.12.0.tar.gz"
  sha256 "56d6a17920709668ab95f68bf453d3ce086e05621604d8ca706b622a435cf5fa"
  license "Apache-2.0"
  head "https://github.com/avrea-com/cli.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    manifest_sha256 "0dff41636a5585c4e66fbcc6fc5dc1cca43d1c975d38f5d59cbdb86eaa1c0145"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "b4d2c7e7cf91c8ae8ddd5e16a005c63b5db9a4ce1c82091d50cb3034f03125f8"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "c507133b9a1484389a720ae0cc2fa15936e8795ac26ae502a329cf250a4ce2f7"
    sha256 cellar: :any,                 x86_64_linux: "6966bc99f54601e980a871125f48d7fcff12b507a71d1e54541bb8a8af55bd09"
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
