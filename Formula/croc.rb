class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://github.com/schollz/croc"
  url "https://github.com/schollz/croc/archive/refs/tags/v11.6.3.tar.gz"
  sha256 "41f5c334be83978fea3f6c90d9b77320db3b381bc65ab57d684c091dd6a1d964"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "50d014bb5a6224d9ed1d6fd04e54ee2eb30fbe0e174a9b5597981fc9154ef1cf"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "0a3fa8f8b227989ded0b36d896916a56e6d236dba7881c3588e8069bb71167d1"
    sha256 cellar: :any,                 x86_64_linux: "06f93be0495a5407471a600d29e72fee096671e2d91d16bf9ba00a13b0361fc7"
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
