class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://schollz.com/software/croc6"
  url "https://github.com/schollz/croc/archive/refs/tags/v10.6.0.tar.gz"
  sha256 "d9ee32d93e8353fd4330d71ee2683f08e22f4a58b2f3f5a73c1c9d622ffd4598"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "38a54cf40936a7d0962126f1451cb05c1b4ecaf718a90181b18b21c9d42d99e9"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "6199dcf10ac1aee356c7eeabc7c62c1e7d3a0c02ab482fee927969862fca9f00"
    sha256 cellar: :any,                 x86_64_linux: "ea663300200a5ee976ad0857b6360941ccf5487d813006a05ca382c0ed326214"
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
