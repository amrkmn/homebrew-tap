class Rustic < Formula
  desc "Fast, encrypted, and deduplicated backups powered by Rust"
  homepage "https://rustic.cli.rs"
  url "https://github.com/rustic-rs/rustic/archive/refs/tags/v0.10.2.tar.gz"
  sha256 "e8305efe543e68f75daec8ac5d7b7831a6ac5860f3dc37a8cfdf40ecf7d1e45f"
  license "Apache-2.0"
  head "https://github.com/rustic-rs/rustic.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "85fd8c816d2cc6291af5143042351495f380da171e029ddfb593c2e6abd00d8a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "11ef1627da14bec0d492ee0ee10b772d255822b8c54982295624a03d42234887"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ccc9c37112d9c85557fe4fd272c0d2fc46ceacffcba94ce505b4b49a70c31b19"
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
