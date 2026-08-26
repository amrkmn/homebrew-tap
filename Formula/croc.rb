class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://getcroc.com/"
  url "https://github.com/schollz/croc/archive/refs/tags/v11.3.2.tar.gz"
  sha256 "441f751cc45d0a66312a54bf5374a6f30e95992e0d71c808d5aaadb62f74cd67"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "48446a2ede7a67070240a3847af801bbb72e84d5208537d3739a9375a093f487"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "7db0b2e7534a12b1533de6c827474baed494e98c5ca8eb293836b8cb0211298d"
    sha256 cellar: :any,                 x86_64_linux: "6b054280f7023a97511015bf40b1731d16ff5184b480c6601f82b75b36151871"
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
    require "socket"
    pid = PTY.spawn(bin/"croc", "relay", "--ports", ports.join(",")).last
    relay_ready = false
    60.times do
      TCPSocket.new("localhost", ports.first).close
      relay_ready = true
      break
    rescue SystemCallError
      sleep 0.5
    end
    flunk "croc relay did not start" unless relay_ready

    pid_send = PTY.spawn(bin/"croc", "--transport=relay",
                                     "--relay=localhost:#{ports.first}", "send",
                                     "--no-local", "--text=mytext", "--transfers=1").last
    sleep 3

    output = shell_output("#{bin}/croc --transport=relay --relay localhost:#{ports.first} --overwrite --yes")
    assert_match "mytext", output
  ensure
    Process.kill("TERM", pid_send)
    Process.kill("TERM", pid)
    Process.wait(pid_send)
    Process.wait(pid)
  end
end
