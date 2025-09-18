class Age < Formula
  desc "Simple, modern, secure file encryption"
  homepage "https://age-encryption.org"
  url "https://github.com/FiloSottile/age/archive/refs/tags/v1.2.1.tar.gz"
  sha256 "93bd89a16c74949ee7c69ef580d8e4cf5ce03e7d9c461b68cf1ace3e4017eef5"
  license "BSD-3-Clause"

  depends_on "go" => :build
  depends_on :linux

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
