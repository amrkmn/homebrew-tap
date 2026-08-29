class Age < Formula
  desc "Simple, modern, secure file encryption"
  homepage "https://age-encryption.org"
  url "https://github.com/FiloSottile/age/archive/refs/tags/v1.3.2.tar.gz"
  sha256 "b07c28c6c4bdafa272073a310b75bc22c49da8904585a89c30e5ca4233e63843"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9233247de73e1d94c0ba786faf7541b6ceeae2a30353c0911a2c78d0dc6097ae"
  end

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.Version=v#{version}"
    system "go", "build", *std_go_args(ldflags:), "./cmd/age"
    system "go", "build", *std_go_args(ldflags:, output: bin/"age-keygen"), "./cmd/age-keygen"

    man1.install "doc/age.1"
    man1.install "doc/age-keygen.1"
  end

  test do
    system bin/"age-keygen", "-o", "key.txt"
    pipe_output("#{bin}/age -e -i key.txt -o test.age", "test", 0)
    assert_equal "test", shell_output("#{bin}/age -d -i key.txt test.age")
  end
end
