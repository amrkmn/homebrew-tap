class DockerCredentialPassage < Formula
  desc "Docker credential helper using age encryption"
  homepage "https://github.com/amrkmn/docker-credential-passage"
  url "https://github.com/amrkmn/docker-credential-passage/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "bc48adb9d1d3ec6451179f3bb457b2e4063d772e85a45c54afe7ee7200d68851"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "0c68f0bf5a317cd4834e4659611a575edad6277849b71766fff58e74bceeca20"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "89104abfd230d2a70fc71faa80103ed4a508a5c921d69d1e190f5bb921d134db"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8424851eddf4d43bcf1d41ee5767c8bd5f5a2adf8fafa4d12bff88487bdd6e2a"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.Version=v#{version}"), "./cmd/docker-credential-passage/main.go"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/docker-credential-passage version")
    assert_match "{}", shell_output("#{bin}/docker-credential-passage list")
  end
end
