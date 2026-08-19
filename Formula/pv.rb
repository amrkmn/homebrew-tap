class Pv < Formula
  desc "Monitor data's progress through a pipe"
  homepage "https://ivarch.com/programs/pv.shtml"
  url "https://codeberg.org/ivarch/pv/releases/download/v1.11.0/pv-1.11.0.tar.gz"
  sha256 "fc02c9fc2b82b20a92cc8d98f844be63f22abd98751a8e4abc875e1d803662eb"
  license "GPL-3.0-or-later"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 arm64_tahoe:  "83bf00fa156509b44dfafb8c31d0758b1f08779ca8e33f366aaed4c04c819443"
    sha256 arm64_linux:  "bbdccca4c103edc20240f33a9d1f4d135954d0c4955d99d79007a1ce9c675cb0"
    sha256 x86_64_linux: "94c75d7387523a5da62603b327a3dbd37e8615f2d63dc7253d821e71c5e7a0bf"
  end

  uses_from_macos "ncurses"

  on_macos do
    depends_on "gettext"
  end

  def install
    # Fix compile with newer Clang
    ENV.append_to_cflags "-Wno-implicit-function-declaration" if DevelopmentTools.clang_build_version >= 1403

    system "./configure", "--mandir=#{man}", *std_configure_args
    system "make", "install"
  end

  test do
    progress = pipe_output("#{bin}/pv -ns 4 2>&1 >/dev/null", "beer")
    assert_equal "100", progress.strip

    assert_match version.to_s, shell_output("#{bin}/pv --version")
  end
end
