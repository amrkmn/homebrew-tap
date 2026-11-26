class Avr < Formula
  desc "Avrea command-line client"
  homepage "https://avrea.com/"
  url "https://github.com/avrea-com/cli/archive/refs/tags/v0.12.0.tar.gz"
  sha256 "56d6a17920709668ab95f68bf453d3ce086e05621604d8ca706b622a435cf5fa"
  license "Apache-2.0"
  head "https://github.com/avrea-com/cli.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    manifest_sha256 "2ead1e4f6745b16b41f25de2f07b02904de36c0ae38ea0869619ac49407c25dd"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "afe13c1bc675ac4f138f72d9f94d778187f4aa8890fa20b9b6ff51ee1f9d8fcf"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "8d664b20684ec8bd05c087832f8681abadcc3f2f8860a1203987a602a8d28935"
    sha256 cellar: :any,                 x86_64_linux: "96c243c680a4ac6a0e2c574e19b8c77d4be6953f4f32e0285417a6467efaa9a2"
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
