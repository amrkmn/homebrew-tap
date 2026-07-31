class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://schollz.com/software/croc6"
  url "https://github.com/schollz/croc/archive/refs/tags/v11.0.0.tar.gz"
  sha256 "6a147e765f5e47d7022cd43f72fcc42e59333a2be0ff09f98bac1d12215f4af0"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "a54dc41150b8736e77103d700c2efdb985f867daa5b3c8d51c5a42778c00d25e"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "d68d760f61dc83e444cc7b19f52fb6212368d0a0dd370777af52b7f77112d216"
    sha256 cellar: :any,                 x86_64_linux: "8fa7c0feb250a14024a006b7cbccc5e0e21ef9b7c16f701a8e64836b3042e017"
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
