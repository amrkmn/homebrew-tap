class DockerCredentialPassage < Formula
  desc "Docker credential helper using age encryption"
  homepage "https://github.com/amrkmn/docker-credential-passage"
  url "https://github.com/amrkmn/docker-credential-passage/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "0b741a05a0d533c74035defe30c79d89e81d5e3a7b12dfb8594b023ffb70ab59"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "05791a9d8796ea687e4fce4377c96fc5ffb80f304f6614421f9cede371634c1c"
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
