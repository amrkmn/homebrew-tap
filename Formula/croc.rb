class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://schollz.com/software/croc6"
  url "https://github.com/schollz/croc/archive/refs/tags/v10.4.7.tar.gz"
  sha256 "fda871fe2f0ed5fdf2248f1ab4d6d88aea08d3582a3a1d2e3e38e916662c7f22"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "821765036765b6abd540619f246123262e06a9760fcac07ccfb7c0dce221607f"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "7cd26e9f7d68c7fc56b8e16967e9e4d5eaa58e69b1149f18cd063abe5a8d37f2"
    sha256 cellar: :any,                 x86_64_linux: "45d703d3ffb1acce75870253e816b2423c77d341b19a89123d6ecff89a3badc9"
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
