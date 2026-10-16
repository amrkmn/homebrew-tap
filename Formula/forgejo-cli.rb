class ForgejoCli < Formula
  desc "CLI tool for interacting with Forgejo"
  homepage "https://codeberg.org/forgejo-contrib/forgejo-cli"
  url "https://codeberg.org/forgejo-contrib/forgejo-cli/archive/v0.7.0.tar.gz"
  sha256 "748ce60eb18e72af83ef3956910933b1e091abf673f12ff9777aea214f6eae40"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://codeberg.org/forgejo-contrib/forgejo-cli.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "7c69c0f2fd7c09b9a3d0689f857dcb94f09c99f794b05750ea7196ed8d02419e"
    sha256 cellar: :any,                 arm64_linux:  "f88e99a8c153965d10385ad54c305edada639879ca055e2f2edd1df10dd918b0"
    sha256 cellar: :any,                 x86_64_linux: "7d6970715fa56d3d386ef95896fa71c86ea3964acd1553f5f8790d6897d1f71d"
  end

  depends_on "pkgconf" => :build
  depends_on "rust" => :build
  depends_on "openssl@4"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    system "cargo", "install", *std_cargo_args

    generate_completions_from_executable(bin/"fj", "completion")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/fj version")

    assert_match "Beyond coding. We forge.", shell_output("#{bin}/fj repo view codeberg.org/forgejo/forgejo")
  end
end
