class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://schollz.com/software/croc6"
  url "https://github.com/schollz/croc/archive/refs/tags/v11.2.3.tar.gz"
  sha256 "99d59ae337ad1ea503e540b14961227be5217667eaee77a33672cb8dd597a35f"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "bff07fd597804d59ae5b0bf826029fd1f892f1d6d25105345d13f610fb114c0f"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "07c3831f69df8d96ad79e3047f02dbd4d1c2f9b4aeca98ba89d5f4674ad8117a"
    sha256 cellar: :any,                 x86_64_linux: "7b042ce1e2e1575dedb45c0e0fc377965fe904e1e6a786d40970794167eb23f3"
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
