class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://github.com/schollz/croc"
  url "https://github.com/schollz/croc/archive/refs/tags/v11.6.5.tar.gz"
  sha256 "2558b6d44f661e4fb32d5146a6c76ce0c2af9a732baeeaf42c717e17245be8b2"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "d92b4a493f3cbc7617e479368ec1907b20dac292b766e42c449bd289d318d844"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "f215509ce703c03ea1e9cd5fc022042279a6d1fcf8517ea0f8c2aeb8022cce5c"
    sha256 cellar: :any,                 x86_64_linux: "631a629e33e411d51e826aa3cd5944e208301b5e5dce44a1ccffad02ad1834b2"
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
