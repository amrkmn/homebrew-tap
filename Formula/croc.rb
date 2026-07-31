class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://schollz.com/software/croc6"
  url "https://github.com/schollz/croc/archive/refs/tags/v11.0.1.tar.gz"
  sha256 "44152e31cf651a9ac2b0492573f562a2784fcf75afa7ff5a9ce815f7ec5352d0"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "255ba6202bca2d1cc7b5ea092ef7d57916c51ff9b31626fd99dd98e2e34dc85b"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "3486bddcb0e3788b47c649aa66ee2a74a4063b502b6d53ba460dd9ed896264e9"
    sha256 cellar: :any,                 x86_64_linux: "f03e9c9efa46da5d1e7d9cc9c9a08776c5bb75e129da560f4c1118c2e6aaa9ea"
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
