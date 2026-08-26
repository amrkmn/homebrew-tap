class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://getcroc.com/"
  url "https://github.com/schollz/croc/archive/refs/tags/v11.3.0.tar.gz"
  sha256 "2af2b2cc379c4a913ee471e7ce157d6bb4ec7a391f0f26f6b870e9422c3ff55b"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "48446a2ede7a67070240a3847af801bbb72e84d5208537d3739a9375a093f487"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "7db0b2e7534a12b1533de6c827474baed494e98c5ca8eb293836b8cb0211298d"
    sha256 cellar: :any,                 x86_64_linux: "6b054280f7023a97511015bf40b1731d16ff5184b480c6601f82b75b36151871"
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
