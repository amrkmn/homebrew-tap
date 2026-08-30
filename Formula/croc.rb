class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://github.com/schollz/croc"
  url "https://github.com/schollz/croc/archive/refs/tags/v11.3.6.tar.gz"
  sha256 "bedca93ce041ed3e5c8d9f7add8cac25d03b97586eac14e54f3f41fe6eb70081"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "ef6a3461ce1cd820ea84a5953cdbd8b180c6f687738a4607c5a87770de3b413e"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "a520b0c0341758e051fc3cffdae98a51a47e9e3dbeb8f9195dfb0278dc2c7ec0"
    sha256 cellar: :any,                 x86_64_linux: "94529b4120a214c2a45f719e06ba05bb744978770285d8662cd5f4afd6e6e883"
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
