class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://github.com/schollz/croc"
  url "https://github.com/schollz/croc/archive/refs/tags/v11.6.1.tar.gz"
  sha256 "3eab929ca02cab1a847880f49e6234acb6f6c547fa21cc9a8f9b515e91151c94"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "b6e462fc2ede5342996dd68a5ba3ef5005d38b641371546c94f8974b20a90b2a"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "3ca028cb57467234da7385dd8e17cf6992b06867dc42513110208092a329317a"
    sha256 cellar: :any,                 x86_64_linux: "eefa1a7d95eccaab853e7e092d08f0e4e7d02f9b057ee89cae0920c2999f5c5e"
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
