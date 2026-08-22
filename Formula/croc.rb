class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://schollz.com/software/croc6"
  url "https://github.com/schollz/croc/archive/refs/tags/v11.2.5.tar.gz"
  sha256 "f26633248287928f1af8755bd92bf366af5feaf10e4bba0ce53f7ad2c57b3372"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "4a79d5aba43730d3df705f0a6d2a637d9f4098a8ca70f13f23687c4ffdea72fa"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "f9aec2349c2f883064de30e664dcc139e770e9e98b7b39e7edeb95eef23f1537"
    sha256 cellar: :any,                 x86_64_linux: "8bb47aa649397faf260b87dc3b43465138ff51db5820f4c03443bebdd1047935"
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
