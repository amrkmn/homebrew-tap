class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://github.com/schollz/croc"
  url "https://github.com/schollz/croc/archive/refs/tags/v11.5.0.tar.gz"
  sha256 "ecca279d7144e8f9052836cd672af359fc93c8bac4d7a8f0b2a16225f7b91cf2"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "f81e45184b26f857919067fd564dde6c385725fdf475d7de32546a2079c21475"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "fc4de48c4528211ba228116100c3121d425c3abf1c5ccb8f62a6993270612b08"
    sha256 cellar: :any,                 x86_64_linux: "30bd1c502beb016d7b8b5c8de8c774a7b032fda738712258569c456376d70260"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
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
