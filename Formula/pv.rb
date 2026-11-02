class Pv < Formula
  desc "Monitor data's progress through a pipe"
  homepage "https://ivarch.com/programs/pv.shtml"
  url "https://codeberg.org/ivarch/pv/releases/download/v1.12.7/pv-1.12.7.tar.gz"
  sha256 "5326ed7ee95ef18039390c0b17891ac28985ac7c7a4235070fab767c1fe37bd8"
  license "GPL-3.0-or-later"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 arm64_tahoe:  "51a106222a0e89e62829cb68bf39ea9346f79a974c70fbf66164c9245d8820d6"
    sha256 arm64_linux:  "5061e8cd26d677ff93473e497a5a697f0f32384efaeb47b1e8ebbf732e7c9fe5"
    sha256 x86_64_linux: "7454bcdb00af8c5871a893d7edd96a0e78d32bad506685e04a6a564d3017f408"
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
