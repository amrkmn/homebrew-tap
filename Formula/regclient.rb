class Regclient < Formula
  desc "Docker and OCI Registry Client in Go and tooling using those libraries"
  homepage "https://regclient.org/"
  url "https://github.com/regclient/regclient/archive/refs/tags/v0.11.6.tar.gz"
  sha256 "6e1d1ba693e0bb47afe6e32fd85513cbb78dc20d9564b5de380a6b5e275a7c83"
  license "Apache-2.0"
  head "https://github.com/regclient/regclient.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "7f8672e9f694f4c444ad94a590eaa3747f1c1d319ddc844c1bf798c2cc2cc803"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "56cce8142f7cf98138ec6913bbb01864c33217f40b28c467e395f1708c8387f3"
    sha256 cellar: :any,                 x86_64_linux: "b960cf13ba768b1b54582dbbd279b665f02761d54dd1b247a492a1096d7a96b3"
  end

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X github.com/regclient/regclient/internal/version.vcsTag=#{version}"
    ["regbot", "regctl", "regsync"].each do |f|
      system "go", "build", *std_go_args(ldflags:, output: bin/f), "./cmd/#{f}"

      generate_completions_from_executable(bin/f, shell_parameter_format: :cobra)
    end
  end

  test do
    output = shell_output("#{bin}/regctl image manifest docker.io/library/alpine:latest")
    assert_match "docker.io/library/alpine:latest", output

    assert_match version.to_s, shell_output("#{bin}/regbot version")
    assert_match version.to_s, shell_output("#{bin}/regctl version")
    assert_match version.to_s, shell_output("#{bin}/regsync version")
  end
end
