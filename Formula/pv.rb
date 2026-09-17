class Pv < Formula
  desc "Monitor data's progress through a pipe"
  homepage "https://ivarch.com/programs/pv.shtml"
  url "https://codeberg.org/ivarch/pv/releases/download/v1.12.0/pv-1.12.0.tar.gz"
  sha256 "31fdbdb449c7143cd2968567bef7599e9f031950e6158ee7bb76e40aebf6ffb8"
  license "GPL-3.0-or-later"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 arm64_tahoe:  "2a07ff8458ca273b70b9f866ac8d55ba67bc5b06bb2b5516a1bb2bbdf355dc60"
    sha256 arm64_linux:  "626f1f34e3eee22a114ddf419d71fd454f56b77df2eac0a25fce9133dfcb4501"
    sha256 x86_64_linux: "5c415aab5d6b8aace8c0f5e970356eac140c77a3288daeb5b70ddbde2fceea0e"
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
