class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://schollz.com/software/croc6"
  url "https://github.com/schollz/croc/archive/refs/tags/v10.3.1.tar.gz"
  sha256 "098f9f7295843b09378dd49877ef189aaafac8e6255a346a5f1f9ce310538312"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "4a9447ed6a20b12009dce0f53ec06d799ac7c341c7927d624157659bf0a686c3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ec0fc953044bd7cff1b23852c645fb3ec4007d679b921f2e59e965ad8d25ec8f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1e6670d4e31056057c49bbeed0ac6bf0b87d72450e31b36391635528750bedcb"
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
