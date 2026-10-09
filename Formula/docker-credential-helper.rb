class DockerCredentialHelper < Formula
  desc "Platform keystore credential helper for Docker"
  homepage "https://github.com/docker/docker-credential-helpers"
  url "https://github.com/docker/docker-credential-helpers/archive/refs/tags/v0.9.10.tar.gz"
  sha256 "547d0cb12c15faedced31487e6a456c63c0faa6e53895da076619733ef8917eb"
  license "MIT"
  head "https://github.com/docker/docker-credential-helpers.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "80023b1f7aafa9f691da3dc977dd197fd9dd59a0ed117263715892c995702f85"
    sha256 cellar: :any,                 arm64_linux:  "843e843f410f0fc03b6956d185b6c49120ea1c315a5a4be8d555ed6679014965"
    sha256 cellar: :any,                 x86_64_linux: "07d98f3c5973f60db545d355a79f09a132db901d6214b13fd1c91c00498a7540"
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
