class DockerCredentialPassage < Formula
  desc "Docker credential helper using age encryption"
  homepage "https://github.com/amrkmn/docker-credential-passage"
  url "https://github.com/amrkmn/docker-credential-passage/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "6b95db102bbdf6aabe14dd855a6123582a99f17dfb3ae0f8af3fc5fbf31f7a94"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6be6f96121c216e8ed9363913bd176b5dcd1b2f9449faa6d001c2c8f9c99b51d"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.Version=#{version}"), "./passage/cmd"
  end

  test do
    assert_match "docker-credential-passage/#{version}", shell_output("#{bin}/docker-credential-passage version")
    assert_match "{}", shell_output("#{bin}/docker-credential-passage list")
  end
end
