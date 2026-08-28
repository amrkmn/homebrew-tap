class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://github.com/schollz/croc"
  url "https://github.com/schollz/croc/archive/refs/tags/v11.3.4.tar.gz"
  sha256 "f851e1e85fa04be3fbe9c1aef11b1da7c6c90fc59986cc498169569abbbd33bc"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "0b70566197e19c04dd9cd4eb1b0c962fd2717d568be46bdc4679549c3bc5b096"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "2dc895bfb8506ba4d824f814771b9d8a6e294f5dab05b3b7072c33c7034a35c1"
    sha256 cellar: :any,                 x86_64_linux: "00974d851d9a61f02f243690c34c85f560ce17b00a070c045db53c16b3e25cdf"
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
