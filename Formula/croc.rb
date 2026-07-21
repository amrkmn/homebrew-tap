class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://schollz.com/software/croc6"
  url "https://github.com/schollz/croc/archive/refs/tags/v10.5.0.tar.gz"
  sha256 "e1a8053091dd00e0c5b9949374df1e2f0671e0d98ea8ff81a447c421312246e4"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "f9f5923c9b0110fe9400e401413fe60c6ac71b073152af076c03f1d802384ee3"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "ffc40363a89ed869c961bbef6b0aa3716498af168e8dfd49e04153f09c23c01e"
    sha256 cellar: :any,                 x86_64_linux: "77988b670d669e7f7ae6ae6f53e5cef6d4b3ad595a263632a09d7bb1f6e3299e"
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
