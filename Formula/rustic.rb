class Rustic < Formula
  desc "Fast, encrypted, and deduplicated backups powered by Rust"
  homepage "https://rustic.cli.rs"
  url "https://github.com/rustic-rs/rustic/archive/refs/tags/v0.10.2.tar.gz"
  sha256 "e8305efe543e68f75daec8ac5d7b7831a6ac5860f3dc37a8cfdf40ecf7d1e45f"
  license "Apache-2.0"
  head "https://github.com/rustic-rs/rustic.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "6518ba06cfffb7da89cbdfe2829a9a47673d662c4a46c485eff26f0857c8e066"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7202c8677afd61e15267e05dedb63f7b0152c9be0d846bc0629fb137524abd51"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c7a88d4351dc22c08b6cbdb045cf7c1f0b859272ceef7945d055bbefd4318a6e"
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
