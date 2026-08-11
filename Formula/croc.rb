class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://schollz.com/software/croc6"
  url "https://github.com/schollz/croc/archive/refs/tags/v11.1.0.tar.gz"
  sha256 "ae71b65f54c48fd2f4d60bb0209a0a18584bb0c744967675b0a0d4f2ffb22e8f"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "61c5121122cd06d21fe056fddedfc287ea95a7991623ddf44125c46089289398"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "7f79e4e23223c454d8f7468295491121f8aa3901bd8bbb5de567048cae310bfc"
    sha256 cellar: :any,                 x86_64_linux: "1b63cddb0e0076d44c871f0351ba08c1b86bd0987387e52c2c0fc6ae41bd5d12"
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
