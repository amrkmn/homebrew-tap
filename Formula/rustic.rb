class Rustic < Formula
  desc "Fast, encrypted, and deduplicated backups powered by Rust"
  homepage "https://rustic.cli.rs"
  url "https://github.com/rustic-rs/rustic/archive/refs/tags/v0.12.0.tar.gz"
  sha256 "41c496bee7dcfad0922d4d9e760be19f713ffaaa55fe92716943ca3ecc62d26e"
  license "Apache-2.0"
  head "https://github.com/rustic-rs/rustic.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "ba63c686b1bfb9b49af0068cfe3eba5c140813b7dd771f8f7c7e6a46577e1442"
    sha256 cellar: :any,                 arm64_linux:  "df57b06953fd44b73566ce80bf306cd054f7149ba36dc004503e7aad3fdac7e8"
    sha256 cellar: :any,                 x86_64_linux: "55f2ad3f93e32305882eb42bca5deb3b65938b20d4f1d95ec36ca508d6171c7c"
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
