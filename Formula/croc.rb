class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://schollz.com/software/croc6"
  url "https://github.com/schollz/croc/archive/refs/tags/v11.2.1.tar.gz"
  sha256 "c3e276f46755f2984cb7958cbe00e01ecf85351d2509d45067b6291abc404d29"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "6f1817541f08fadb1081a2b1489e7593ffd15d1dc30db75fb490d5e6483209f3"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "c961bacdd2f64da567f4498c229c78803d66324bdc9f5b2b8957db5377d046f7"
    sha256 cellar: :any,                 x86_64_linux: "211378f36f2c9b48fa87fb86cabd4c7cd3fb4c397798e7a85c56a9214ccf7773"
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
