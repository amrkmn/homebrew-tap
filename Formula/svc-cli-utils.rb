class SvcCliUtils < Formula
  desc "Command-line utilities for Simple Voice Chat"
  homepage "https://github.com/henkelmax/svc-cli-utils"
  url "https://github.com/henkelmax/svc-cli-utils/archive/refs/tags/1.0.4.tar.gz"
  sha256 "a9d32c97f33968294e05b339daf8f25ecb6c82c9018a2a7e50c1bc10add89f89"
  license :cannot_represent

  depends_on "rust" => :build

  def install
    inreplace "Cargo.toml", /^version = ".*"/, "version = \"#{version}\""
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "svc #{version}", shell_output("#{bin}/svc --version")
  end
end
