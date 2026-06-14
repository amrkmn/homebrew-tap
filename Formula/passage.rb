class Passage < Formula
  desc "Password store using age encryption"
  homepage "https://github.com/FiloSottile/passage"
  url "https://github.com/FiloSottile/passage/archive/refs/tags/1.7.4a2.tar.gz"
  version "1.7.4a2"
  sha256 "d4bd97be2eda4249b31c2042707ef70ba50385f6fb7791598f51be794168ee2c"
  license "GPL-2.0-or-later"
  revision 1
  head "https://github.com/FiloSottile/passage.git", branch: "main"

  depends_on "age"
  depends_on "qrencode"
  depends_on "tree"

  on_macos do
    depends_on "gnu-getopt"
  end

  def install
    system "make", "PREFIX=#{prefix}",
           "WITH_BASHCOMP=yes",
           "WITH_ZSHCOMP=yes",
           "WITH_FISHCOMP=yes",
           "install"

    inreplace bin/"passage",
              /^SYSTEM_EXTENSION_DIR=.*$/,
              "SYSTEM_EXTENSION_DIR=\"#{HOMEBREW_PREFIX}/lib/passage/extensions\""
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/passage 2>&1", 1)
    assert_path_exists "#{share}/bash-completion/completions/passage"
    assert_path_exists "#{share}/zsh/site-functions/_passage"
    assert_path_exists "#{share}/fish/vendor_completions.d/passage.fish"
  end
end
