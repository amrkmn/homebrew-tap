class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://schollz.com/software/croc6"
  url "https://github.com/schollz/croc/archive/refs/tags/v10.2.4.tar.gz"
  sha256 "c259c07b9da3ea39726b0c5e3f78ae66e858e1379bdb11bef93d31298e68f5fe"
  license "MIT"
  head "https://github.com/schollz/croc.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "bb20143db981cc2695da82cb5ea91c691720e66282ab5abfcf2d39a35bee5823"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0b2c298b5480a55036381b5c669ac50320dd7c02938f49afaa239ac3c1e22177"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9714b5800c7a3c81128130fce41da8f42c3287f995511cdd83751bdbd392b265"
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
