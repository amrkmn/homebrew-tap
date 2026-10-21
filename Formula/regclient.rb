class Regclient < Formula
  desc "Docker and OCI Registry Client in Go and tooling using those libraries"
  homepage "https://regclient.org/"
  url "https://github.com/regclient/regclient/archive/refs/tags/v0.11.7.tar.gz"
  sha256 "a648fcf3b5b81c55773f47f6d7401d1904675c32520a76159d960a9e8798badd"
  license "Apache-2.0"
  head "https://github.com/regclient/regclient.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "dc5cec18deda2d4796db86dba26c6dfe12692a18858a81f936d2a5d50f001617"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "c7a642f276e097735dcfa130eab4f8ec5ecc84e03afd2df330dcff1b1987d30d"
    sha256 cellar: :any,                 x86_64_linux: "cb3478ce1b5268275205d379f8b9745102ba0451482093f29dcc4037b6bd10fc"
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
