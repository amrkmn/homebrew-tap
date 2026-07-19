class ForgejoCli < Formula
  desc "CLI tool for interacting with Forgejo"
  homepage "https://codeberg.org/forgejo-contrib/forgejo-cli"
  url "https://codeberg.org/forgejo-contrib/forgejo-cli/archive/v0.6.0.tar.gz"
  sha256 "8b91194cb1886f253261a4567ee6f83aa34b05a9637644793f88b40b7110322a"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://codeberg.org/forgejo-contrib/forgejo-cli.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256               arm64_tahoe:  "d943c9627239c5fa59c75c7c337c85ca1e4e46edd9f8fb0ca5e60db2a61391cd"
    sha256 cellar: :any, arm64_linux:  "57196aa9da239dfc44f34fbfcd95e5d76e020f055cee71060a027066f6b619db"
    sha256 cellar: :any, x86_64_linux: "f524aaaf17357f1da7746c4e9fb90c0df3d847060d425e71dc72293ba79cdc7b"
  end

  depends_on "pkgconf" => :build
  depends_on "rust" => :build
  depends_on "openssl@3"

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
