class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://schollz.com/software/croc6"
  url "https://github.com/schollz/croc/archive/refs/tags/v10.4.8.tar.gz"
  sha256 "60f8a15a6fde7bea34730374b66bf8b3162770cf047fbf52cdd574f4807c6a7b"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "72c8a04f6df474febbd5c0a0621c9109035924d9372366f0d42b468e2c58aadf"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "f32a34c959c0b5fa1c36745cfcf6136b7f205872c44bb83ed6b30d7bf6da3136"
    sha256 cellar: :any,                 x86_64_linux: "42289f57e85869f1ad70b3be8afb7a80c7dad61c58619ff522f93a6c45c00a02"
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
