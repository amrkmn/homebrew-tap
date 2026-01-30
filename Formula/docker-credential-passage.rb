class DockerCredentialPassage < Formula
  desc "Docker credential helper using age encryption"
  homepage "https://github.com/amrkmn/docker-credential-passage"
  url "https://github.com/amrkmn/docker-credential-passage/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "b9d32646f6ac944fc0516e23a5056d643ccc7be3f5254e6b3b6331814d3b8e09"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e8773922ea94113e09e90727fc88195b32facb8c65c48aa0227453d85148998e"
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
