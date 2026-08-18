class Rustic < Formula
  desc "Fast, encrypted, and deduplicated backups powered by Rust"
  homepage "https://rustic.cli.rs"
  url "https://github.com/rustic-rs/rustic/archive/refs/tags/v0.11.4.tar.gz"
  sha256 "ea1796a66c22e2cd0232ee4d3e18cf95c7eb8608a465481023a6422f4720d2c3"
  license "Apache-2.0"
  head "https://github.com/rustic-rs/rustic.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "994d533ae3c7256fd0c4ef7c67c1863af1d12c1fcb214c0fa6c4ab1f1d95f9aa"
    sha256 cellar: :any,                 arm64_linux:  "f7a63fdfc32294113763b29af4d35a041744d2acf4d3cf1790380b844f2aae66"
    sha256 cellar: :any,                 x86_64_linux: "a3ef5f7ecc298086bbe737ec08dca54c97faba4b608f6607a87a88cc4e1faf25"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
    generate_completions_from_executable(bin/"rustic", "completions")
  end

  test do
    mkdir testpath/"rustic_repo"
    ENV["RUSTIC_REPOSITORY"] = testpath/"rustic_repo"
    ENV["RUSTIC_PASSWORD"] = "test"

    (testpath/"testfile").write("test test test")

    system bin/"rustic", "init"
    system bin/"rustic", "backup", "testfile"

    system bin/"rustic", "restore", "latest:testfile", testpath/"testfile_restore"
    assert compare_file testpath/"testfile", testpath/"testfile_restore"
  end
end
