class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://github.com/schollz/croc"
  url "https://github.com/schollz/croc/archive/refs/tags/v11.6.7.tar.gz"
  sha256 "2481acb7c027c89201979cfddf848826ff485512c36eed364e174c3b032c8748"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    manifest_sha256 "fc016a08fdd8c656e59045d4717f658842bb25dffcf062c35ed2d5d2742fa349"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "0cd94a88f5e41a4ffab924818c3f1b719e7586b0abe3d8f526330972b8c26f9c"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "c1991872d285f1d0a9e81632a92151d643c96fc1da269a18e866950b9c78c468"
    sha256 cellar: :any,                 x86_64_linux: "93a11b83a64273dd27b06a100e521975c094995012758d1a415c452f9ae89210"
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
