class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://github.com/schollz/croc"
  url "https://github.com/schollz/croc/archive/refs/tags/v11.5.1.tar.gz"
  sha256 "7f1ff12d55ac971e7ab85e230313fc25a996ac4f4c103d6cf336edb23e0d63b4"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "448c2ed44cd4fd56c2c6adf9808c010020a4b567ebcf4461425aa7d14163bf73"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "f934873cdacdbabb0248de49951c0b121e1d2b9434bf60f74fba93aa30308929"
    sha256 cellar: :any,                 x86_64_linux: "f9343a17696f87b647e35f8c223ff8de544b50038a53e3ab6b55d20fc80411de"
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
