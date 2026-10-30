class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://github.com/schollz/croc"
  url "https://github.com/schollz/croc/archive/refs/tags/v11.6.0.tar.gz"
  sha256 "dfb0101c1ca656b3ddc4d0fce922f5feb0b9395b301515d771f496f3e8e514fb"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "fd81e8f884f36c8c318a2354d4098f697e485b67b6e387e4b219e6de79cb186d"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "5c159ac516d5ffc3c05015e5e8a9f2afa1b987c85e0c4afbcd3e174ae65352af"
    sha256 cellar: :any,                 x86_64_linux: "7e6f5ba224523cf6aaeed2842620f59d710d9377a2adf6e4f774f15a714c559c"
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
