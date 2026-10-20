class DockerCredentialHelper < Formula
  desc "Platform keystore credential helper for Docker"
  homepage "https://github.com/docker/docker-credential-helpers"
  url "https://github.com/docker/docker-credential-helpers/archive/refs/tags/v0.9.12.tar.gz"
  sha256 "26fe64555610f1cf521628b957f91e811ea64c47182d4dc19261e3aed5a1bea7"
  license "MIT"
  head "https://github.com/docker/docker-credential-helpers.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "552573a4d073126af8912b24f70cce2295199b3bca0a033716cdbd1d7440a94c"
    sha256 cellar: :any,                 arm64_linux:  "ba03e9f13dac7bcc855372b5dd26247665bea5df53f2ebf2f36e6102d89cdbba"
    sha256 cellar: :any,                 x86_64_linux: "a26649d127ec7360c2c6818f4208315fe6aa34bd695316014a355d45b8954ccd"
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
