class Qmd < Formula
  desc "On-device hybrid search engine for markdown notes, docs, and knowledge bases"
  homepage "https://github.com/tobi/qmd"
  url "https://registry.npmjs.org/@tobilu/qmd/-/qmd-2.9.0.tgz"
  sha256 "436ce43f4dd9e64ee734c86964195aa049f0abc34ab9ed6d90608ad4b20665d4"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any, arm64_tahoe:  "6699c97193d5ed71897a10f318c114c0966a200b8818573e2c20207e3f5e75b7"
    sha256 cellar: :any, arm64_linux:  "db50805441e4c10f1586823b4c1a13e8c258cdf099c8436120a21883f654a38b"
    sha256 cellar: :any, x86_64_linux: "4fc4f4f8370fcfdd59ab12634c48ce75709bc83fb09eec244b26c0da4085f7e6"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")

    os = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.intel? ? "x64" : "arm64"

    # Remove non-native architecture prebuilds
    libexec.glob("lib/node_modules/@tobilu/qmd/node_modules/@node-llama-cpp/*").each do |dir|
      rm_r dir if dir.basename.to_s != "#{os}-#{arch}"
    end
    libexec.glob("lib/node_modules/@tobilu/qmd/node_modules/*/prebuilds/*").each do |dir|
      rm_r dir unless dir.basename.to_s.start_with?("#{os}-#{arch}")
    end

    # Some upstream packages mislabel prebuilds (e.g. a linux-arm64 build that
    # is actually x86_64), so verify the real architecture of what remains.
    native = Hardware::CPU.arm? ? ["aarch64", "arm64"] : ["x86-64", "x86_64"]
    foreign = Hardware::CPU.arm? ? ["x86-64", "x86_64"] : ["aarch64", "arm64"]
    libexec.glob("lib/node_modules/**/*.{node,so}").each do |file|
      next unless file.file?

      out = Utils.safe_popen_read("file", "-b", file.to_s)
      rm file if foreign.any? { |arch| out.include?(arch) } && native.none? { |arch| out.include?(arch) }
    end
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
