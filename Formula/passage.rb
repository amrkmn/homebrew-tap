class Passage < Formula
  desc "Password store using age encryption"
  homepage "https://github.com/FiloSottile/passage"
  url "https://github.com/FiloSottile/passage/archive/refs/tags/1.7.4a2.tar.gz"
  version "1.7.4a2"
  sha256 "d4bd97be2eda4249b31c2042707ef70ba50385f6fb7791598f51be794168ee2c"
  license "GPL-2.0-or-later"
  revision 1
  head "https://github.com/FiloSottile/passage.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "a46f3d2477a532897e201d0ddf86cea1bf10ded696bcc6f791ebd77fd6f34a06"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "512934994e48009371b7d6d215026f5fad1c6411ca91bd875d153a528aa3a1ff"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d5934f34b5f05b86763a44dcf2419c7ae54239dd03e76db7de77138d345c9e17"
  end

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
