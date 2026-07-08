class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://schollz.com/software/croc6"
  url "https://github.com/schollz/croc/archive/refs/tags/v10.4.12.tar.gz"
  sha256 "9eeb03fef37159619a2e5a668995d4aa5dbab3d9acfa395841d08ffbcae54c02"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "02634d9965c9ee526eef777eb8e8a630fa94c8e000a4fb5bb4a63dc6d9aedb68"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "b72e8400b8371d536943e551a4470db70f0fef952092f4f501b7514c2d1f7a0e"
    sha256 cellar: :any,                 x86_64_linux: "b281639bb273b14274f4016a8f583dc5edee498e6a247a045c27499672bcc1db"
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
