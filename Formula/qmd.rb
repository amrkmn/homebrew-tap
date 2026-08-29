class Qmd < Formula
  desc "On-device hybrid search engine for markdown notes, docs, and knowledge bases"
  homepage "https://github.com/tobi/qmd"
  url "https://registry.npmjs.org/@tobilu/qmd/-/qmd-2.8.3.tgz"
  sha256 "2e60829913a0c646234a905cefd61043167a1392fdcfd19bc54f890af89ca0f0"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any, arm64_tahoe:  "e63d2ea6d3d05e12062bc90b628156e342dfa31020af0872eb8fc63967c8e24e"
    sha256 cellar: :any, arm64_linux:  "62fdadc217b4fb200f93c4d95aa6477a0f70dabd9334064d514da63d073a4dc6"
    sha256 cellar: :any, x86_64_linux: "7828563a3cb4a554230a1410a3464f4b13894a59770785df99ceccad33ce1114"
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
