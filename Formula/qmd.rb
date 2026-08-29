class Qmd < Formula
  desc "On-device hybrid search engine for markdown notes, docs, and knowledge bases"
  homepage "https://github.com/tobi/qmd"
  url "https://registry.npmjs.org/@tobilu/qmd/-/qmd-2.8.3.tgz"
  sha256 "2e60829913a0c646234a905cefd61043167a1392fdcfd19bc54f890af89ca0f0"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    assert_match "qmd #{version}", shell_output("#{bin}/qmd --version")

    (testpath/"project").mkpath
    (testpath/"project"/"notes").mkpath
    (testpath/"project"/"notes"/"security.md").write <<~EOS
      # Auth

      Tokens are issued via the OAuth2 flow. The session cookie expires after 24 hours.
    EOS
    (testpath/"project"/"notes"/"config.md").write <<~EOS
      # Config

      Set MAX_CONNECTIONS to 100 in the settings file.
    EOS

    Dir.chdir(testpath/"project") do
      ENV["PWD"] = (testpath/"project").to_s
      system bin/"qmd", "init"
      system bin/"qmd", "collection", "add", "notes"
      system bin/"qmd", "update"

      assert_includes shell_output("#{bin}/qmd search --json OAuth2"), "notes/security.md"
      assert_includes shell_output("#{bin}/qmd search --json MAX_CONNECTIONS"), "notes/config.md"
    end
  end
end
