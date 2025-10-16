class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://schollz.com/software/croc6"
  url "https://github.com/schollz/croc/archive/refs/tags/v10.2.7.tar.gz"
  sha256 "eea957c840041e11cc214b5f9c31801b0f8b51621d6629b89ba5743788d8e7c6"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "83c39291ac516b641010f890dfd41c0d699a0c7bd7138f0b2856d4209f7005a4"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "41d4d16289ec89d1b64d5cb6e49f7d8f00b912a3ec4e7dac89fa142ddc05a5e0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7e5e34b5fd8c2ef7a63a96c979b1e661f14a3159199dba80b5e6c5bac49037e5"
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
