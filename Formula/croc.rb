class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://github.com/schollz/croc"
  url "https://github.com/schollz/croc/archive/refs/tags/v11.5.3.tar.gz"
  sha256 "194ec2494f1801d7baa597d30ab6571f4a25f645cf0527aa7a4b66cd5b7a6fa8"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "1c00ea2aed6acb3688b7fc2952bbafb05d0af4ba2ffc33a14a65e3dec07e18da"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "e844d69412a69cffab0d890be230013cf3097885edb5605eca77abdb1f0957f4"
    sha256 cellar: :any,                 x86_64_linux: "097eedd43c6461daf821a4fc210e0ee8133863028f5d382cbe7307937a45618f"
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
