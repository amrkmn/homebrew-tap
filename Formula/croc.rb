class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://github.com/schollz/croc"
  url "https://github.com/schollz/croc/archive/refs/tags/v11.6.5.tar.gz"
  sha256 "2558b6d44f661e4fb32d5146a6c76ce0c2af9a732baeeaf42c717e17245be8b2"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "830571259610c44506e5baf5a6c8e64d2f18506dc37b70baa809c9ea746c7aaa"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "271eb55ee7a9b016781ad6700485978ae713ddce23178e6b0c269c6d492ad380"
    sha256 cellar: :any,                 x86_64_linux: "10d9ac695a1578a05a998550a5fb98a90018cac671f382167fcd06c6251eb3d8"
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
