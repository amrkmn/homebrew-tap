class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://schollz.com/software/croc6"
  url "https://github.com/schollz/croc/archive/refs/tags/v11.0.0.tar.gz"
  sha256 "6a147e765f5e47d7022cd43f72fcc42e59333a2be0ff09f98bac1d12215f4af0"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "c554c5994b8505b41f4594be6f3e5fa13b20db781e098c9dea6334dd1744b43b"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "1063000bcb10f3a8710f136e2d3bb118b4db4b54068597cf8d158915877e4006"
    sha256 cellar: :any,                 x86_64_linux: "3d9bf2fc79582b5ff63dd6e9d8c88c362558b5c042bb99243d1682fd63ee5bff"
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
