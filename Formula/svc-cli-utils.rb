class SvcCliUtils < Formula
  desc "Command-line utilities for Simple Voice Chat"
  homepage "https://github.com/henkelmax/svc-cli-utils"
  url "https://github.com/henkelmax/svc-cli-utils/archive/refs/tags/1.0.4.tar.gz"
  sha256 "a9d32c97f33968294e05b339daf8f25ecb6c82c9018a2a7e50c1bc10add89f89"
  license :cannot_represent

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "bd67037bcc4e55fe1755da85620aa237c5a409365f12c498dd68d7d026e992b3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9f5292c9891768f5e6f8601560a5a4731896bc70d7832a5020db2300be9cb01d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6a79d7410c06114994217bb11b0c32ad212188713a0d1d9c3a82b2823d77c572"
  end

  depends_on "rust" => :build

  def install
    inreplace "Cargo.toml", /^version = ".*"/, "version = \"#{version}\""
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "svc #{version}", shell_output("#{bin}/svc --version")
  end
end
