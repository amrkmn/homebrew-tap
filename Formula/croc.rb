class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://schollz.com/software/croc6"
  url "https://github.com/schollz/croc/archive/refs/tags/v10.4.8.tar.gz"
  sha256 "60f8a15a6fde7bea34730374b66bf8b3162770cf047fbf52cdd574f4807c6a7b"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "ff7e16060c1625a5332cd71f74aba33636c15bf0b649944b9e6dabfc2659ca29"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "f3f9c74dfb655279e978abbc59da17de82ffd064e2272c0f41affce4f264ebfd"
    sha256 cellar: :any,                 x86_64_linux: "293a6bddad7c33623e625a37a0f8321c4a9644692e4243bc91a1eb9fbb2e35bd"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    # As of https://github.com/schollz/croc/pull/701 an alternate method is used to provide the secret code
    ENV["CROC_SECRET"] = "homebrew-test"

    ports = [free_port, free_port]

    require "pty"
    pid = PTY.spawn(bin/"croc", "relay", "--ports", ports.join(",")).last
    sleep 3

    pid_send = PTY.spawn(bin/"croc", "--relay=localhost:#{ports.first}", "send",
                                      "--no-local", "--text=mytext", "--transfers=1").last
    sleep 3

    output = shell_output("#{bin}/croc --relay localhost:#{ports.first} --overwrite --yes")
    assert_match "mytext", output
  ensure
    Process.kill("TERM", pid_send)
    Process.kill("TERM", pid)
    Process.wait(pid_send)
    Process.wait(pid)
  end
end
