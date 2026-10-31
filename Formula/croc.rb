class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://github.com/schollz/croc"
  url "https://github.com/schollz/croc/archive/refs/tags/v11.6.0.tar.gz"
  sha256 "dfb0101c1ca656b3ddc4d0fce922f5feb0b9395b301515d771f496f3e8e514fb"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "8fa815eb190f1ceb48b1f6b43ca24f65f12de2c348a49cba016f161ac99cb8b8"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "b2c3ef6305d0e70cec58b9163a1f1955a1f7a8df1c8cc85d92bb4dd8d0048c77"
    sha256 cellar: :any,                 x86_64_linux: "53401fa196d49448af6fd696395bc3194b802f05b5714b6dd350780e3769055c"
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
