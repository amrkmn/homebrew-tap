class ForgejoCli < Formula
  desc "CLI tool for interacting with Forgejo"
  homepage "https://codeberg.org/forgejo-contrib/forgejo-cli"
  url "https://codeberg.org/forgejo-contrib/forgejo-cli/archive/v0.6.0.tar.gz"
  sha256 "8b91194cb1886f253261a4567ee6f83aa34b05a9637644793f88b40b7110322a"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://codeberg.org/forgejo-contrib/forgejo-cli.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any, x86_64_linux: "c8524873de7c16a21e81398a18b0015aa5550e04d4f6f2166650e6b458ded1e5"
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
