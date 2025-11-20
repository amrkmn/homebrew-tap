class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://schollz.com/software/croc6"
  url "https://github.com/schollz/croc/archive/refs/tags/v10.3.1.tar.gz"
  sha256 "098f9f7295843b09378dd49877ef189aaafac8e6255a346a5f1f9ce310538312"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "4f104fb2cdfede052f13672c6f69bde11efc265140f8fe072b61d0b8a175c6f0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7cae90911f249cb6589042b96d686eb73c6bc7311c16f6d55da0056fb3be9c19"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "01e1f78180946b07f1f6c9bb405fa2e9966416e2d68be3aa47d9b619efeb1161"
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
