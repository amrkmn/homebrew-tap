class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://schollz.com/software/croc6"
  url "https://github.com/schollz/croc/archive/refs/tags/v11.1.2.tar.gz"
  sha256 "8470b63320b0c8823b5866710a2bb8c222bcf79dcd97b887ba881e76f34fa0d2"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "8ca9d98fb5bd559fdf63e4ef30dd1b56ba088f7a5eb2d5e51c8c3431c5a405b3"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "ca5cee80d10e2d90fa4a9f9c754f27a03fcd7028bcb1a2a11f97865ceb21f274"
    sha256 cellar: :any,                 x86_64_linux: "0b34cbcc0fd01699ded9771470a43ebee35dfa121ab4f14febf9afc233f4c71c"
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
