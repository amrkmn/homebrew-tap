class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://github.com/schollz/croc"
  url "https://github.com/schollz/croc/archive/refs/tags/v11.5.2.tar.gz"
  sha256 "2ceddb504be8b5912f4a3bfd76dc28bb18afda54191f2bebcf5b0fb24e63f774"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "4be3ceedbf6bfa6aab2703da75ed895fb3f87b2e1c4fa4115805bf6b64618208"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "ea8b0ff28f93afa3c7c59cfaa45c6c8b8934cb36773c025b80644aa44ac3caf6"
    sha256 cellar: :any,                 x86_64_linux: "7a5f7f8d328fac0ee04318ae28ab7b0d7c3907ea72f234a2e6d0c0cfbbc29bc3"
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
