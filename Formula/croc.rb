class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://schollz.com/software/croc6"
  url "https://github.com/schollz/croc/archive/refs/tags/v10.2.5.tar.gz"
  sha256 "993e0bb72e79c5168d78db5c14d84f69beeab819ab4d06f4d98fcddd23487207"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "7e3f3b68400ae9bafbc2ca8aad529ada93c795d4c3f2a7830c61761c8a298f63"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0d28ed2c7a306d5ecf76ba6165d8cc73894f00e9192f76b2ad8e8065ac954175"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "463d276f416725c14482ef5247a179864ad580b94a562ae40367ca3d50e33044"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    # As of https://github.com/schollz/croc/pull/701 an alternate method is used to provide the secret code
    ENV["CROC_SECRET"] = "homebrew-test"

    port=free_port

    fork do
      exec bin/"croc", "relay", "--ports=#{port}"
    end
    sleep 3

    fork do
      exec bin/"croc", "--relay=localhost:#{port}", "send", "--code=homebrew-test", "--text=mytext"
    end
    sleep 3

    assert_match shell_output("#{bin}/croc --relay=localhost:#{port} --overwrite --yes homebrew-test").chomp, "mytext"
  end
end
