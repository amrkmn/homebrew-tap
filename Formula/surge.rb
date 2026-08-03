class Surge < Formula
  desc "Blazing fast TUI download manager built in Go for power users"
  homepage "https://github.com/SurgeDM/Surge"
  url "https://github.com/SurgeDM/Surge/archive/refs/tags/v0.11.2.tar.gz"
  sha256 "a8c9cb5c8af161959a89bbbae551a9fe28180d6c5e5315d03a1b7b5cc730d102"
  license "MIT"
  head "https://github.com/SurgeDM/Surge.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "f91673abe40c2bac925927fd79c77aeeb8bf8559373a1afd513b06b11eafabd4"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "5b93e43d075f10529d1268472e3b2fb6b5efbb0dd41f4f20895b0152adc2e904"
    sha256 cellar: :any,                 x86_64_linux: "9a022f689a3c0f79ca52ed94ef1ca5c99daca83cd35e27d16386d685e3f68920"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/SurgeDM/Surge/cmd.Version=#{version}
    ]
    system "go", "build", *std_go_args(ldflags:)
  end

  test do
    ENV["HOME"] = testpath

    assert_match "v#{version}", shell_output("#{bin}/surge --version")
    assert_match "TUI download manager", shell_output("#{bin}/surge --help")
    assert_match "NOT running", shell_output("#{bin}/surge server status")
    assert_match "No downloads found", shell_output("#{bin}/surge ls")
  end
end
