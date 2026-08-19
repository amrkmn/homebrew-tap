class Pv < Formula
  desc "Monitor data's progress through a pipe"
  homepage "https://ivarch.com/programs/pv.shtml"
  url "https://codeberg.org/ivarch/pv/releases/download/v1.10.0/pv-1.10.0.tar.gz"
  sha256 "998e717419c02ee735aea0b8d57f9cbe1112f40f4b947a39ba2611a415b64da0"
  license "GPL-3.0-or-later"

  livecheck do
    url :stable
    strategy :git
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
