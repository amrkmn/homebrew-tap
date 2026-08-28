class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://github.com/schollz/croc"
  url "https://github.com/schollz/croc/archive/refs/tags/v11.3.3.tar.gz"
  sha256 "13218971aa54b34def16288c70417ab5b2653d5f68082f77445b4b8963ebb430"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "52dce781d78d2c270caca902bd7e1417cb2fc13a1bf49532c871f2d54ed5f9db"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "9b51c18e1d290d1fb1b99845c8d8c300d4806949abf4c9132ee71c84311f685e"
    sha256 cellar: :any,                 x86_64_linux: "920b091333719e1cd71bfe4c333d459ab3fede3f9f29cc4f47cc81cf09eca376"
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
