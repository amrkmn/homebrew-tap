class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://schollz.com/software/croc6"
  url "https://github.com/schollz/croc/archive/refs/tags/v11.1.2.tar.gz"
  sha256 "8470b63320b0c8823b5866710a2bb8c222bcf79dcd97b887ba881e76f34fa0d2"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "69d620a66a1440b43a11fa3e50834b774b0c36a1594bbd266f7b744f49cfc113"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "d39baba2f9789c3164a97d7bf37cef7b854db7b1cafedbe7e4afa56e5421ffd4"
    sha256 cellar: :any,                 x86_64_linux: "e1fb390173a28a06f5cfbd29855bec88f9d6ff57c94a28e7adbf85804bb2b19f"
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
