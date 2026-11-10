class DockerCredentialHelper < Formula
  desc "Platform keystore credential helper for Docker"
  homepage "https://github.com/docker/docker-credential-helpers"
  url "https://github.com/docker/docker-credential-helpers/archive/refs/tags/v0.9.13.tar.gz"
  sha256 "b5bdcd9fe7539cbb4feb90aaf734e76c1232cd9ec5f0c976ad549657f53d7048"
  license "MIT"
  head "https://github.com/docker/docker-credential-helpers.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "ba5029c1a9be973d91fdc00af071d2bb1f358830290d9b7ddd1c3b3505bca6c3"
    sha256 cellar: :any,                 arm64_linux:  "78e239cf1ee4904ad0c50bfcb29a86a6ded3227d1f2246f53757707c5549d65b"
    sha256 cellar: :any,                 x86_64_linux: "85520dedc5f1e48f42b25ba850c2451e78519ff1e7d4a381d2f365105cab1015"
  end

  depends_on "go" => :build
  depends_on "pkgconf" => :build

  on_linux do
    depends_on "glib"
    depends_on "libsecret"
  end

  def install
    ENV["CGO_ENABLED"] = "1" if OS.linux? && Hardware::CPU.arm?

    if OS.mac?
      system "make", "osxkeychain"
      bin.install "bin/build/docker-credential-osxkeychain"
    else
      system "make", "secretservice"
      bin.install "bin/build/docker-credential-secretservice"
    end
    system "make", "pass"
    bin.install "bin/build/docker-credential-pass"
  end

  test do
    if OS.mac?
      run_output = shell_output("#{bin}/docker-credential-osxkeychain", 1)
      assert_match "Usage: docker-credential-osxkeychain", run_output
    else
      run_output = shell_output("#{bin}/docker-credential-secretservice list", 1)
      assert_match "Cannot autolaunch D-Bus without X11", run_output
    end
    run_output = shell_output("#{bin}/docker-credential-pass list")
    assert_match "{}", run_output
  end
end
