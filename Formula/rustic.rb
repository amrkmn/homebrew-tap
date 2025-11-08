class Rustic < Formula
  desc "Fast, encrypted, and deduplicated backups powered by Rust"
  homepage "https://rustic.cli.rs"
  url "https://github.com/rustic-rs/rustic/archive/refs/tags/v0.10.1.tar.gz"
  sha256 "efd310855d44758ed0e3cc4bb51ffc8bff59ff160c942f46988f03ef978764cf"
  license "Apache-2.0"
  head "https://github.com/rustic-rs/rustic.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "410eb121e3b83c2c1bc73403bf8900da0588159d2b96b3ee60bf2f1546f7b66f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1d8a5509f1b90518a86e975e34b79370677cea6909a2b9bf7c2b857d01f30cbb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b15d9813f8dd68d5e3cdfb5e05f4d244becbd6f138cbd016267f39945b31eb27"
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
