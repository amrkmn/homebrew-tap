class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://schollz.com/software/croc6"
  url "https://github.com/schollz/croc/archive/refs/tags/v11.2.4.tar.gz"
  sha256 "583d6174593fd59e92565cdbf8424c9307efb22ffa66acc70f3539500158e9c5"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "91322a761ee7df3ff9ee0a34bab008d14043c995d438ef7bfaa00a38468eb407"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "aadfedc1855e46c042efe695dfad585a6c18771c155a5b01bb92ace342d6ab90"
    sha256 cellar: :any,                 x86_64_linux: "ee9f7bb6983be3ea7db8633cfe1d1899a48c0cc531f429f6d5f35db5eb7cb4f6"
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
