class Age < Formula
  desc "Simple, modern, secure file encryption"
  homepage "https://age-encryption.org"
  url "https://github.com/FiloSottile/age/archive/refs/tags/v1.2.1.tar.gz"
  sha256 "93bd89a16c74949ee7c69ef580d8e4cf5ce03e7d9c461b68cf1ace3e4017eef5"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a5818c0e692453c346c5a728e0fed44de47285e89a76180e25f731aeaf8745ba"
  end

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
