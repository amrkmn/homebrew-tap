class DockerCredentialPassage < Formula
  desc "Docker credential helper using age encryption"
  homepage "https://github.com/amrkmn/docker-credential-passage"
  url "https://github.com/amrkmn/docker-credential-passage/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "35b42c1c582a4c961ed1710028e7f9cd8f54e5f76d341ba6375bacfaee627d69"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "afe4dbb1d2bcdfc7c29be4d70c2f8555c434662e7c313f167c5a407413a420ab"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.Version=#{version}"), "./passage/cmd"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/docker-credential-passage version")
    assert_match "{}", shell_output("#{bin}/docker-credential-passage list")
  end
end
