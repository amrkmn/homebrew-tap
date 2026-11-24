class GeminiCli < Formula
  desc "Interact with Google Gemini AI models from the command-line"
  homepage "https://github.com/google-gemini/gemini-cli"
  url "https://registry.npmjs.org/@google/gemini-cli/-/gemini-cli-0.71.0.tgz"
  sha256 "d80135d4028598cb19cd92f66b531795bfb5801968bfe77e347b78cf1ae9a486"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "eed37e3aa8b1e785f333567db96c532df473e4fa2c24fe913e6ceca705654c7a"
    sha256 cellar: :any,                 arm64_linux:  "7da00f1eae8c5ace0f45e94a92a6e9f0f69207698a64c09af12bbdfe6017a46e"
    sha256 cellar: :any,                 x86_64_linux: "136c7f1305a0b2a38f66a51d327a708e716ccbd24fac7ae0121c0bb8fa21b0ee"
  end

  depends_on "node"

  on_linux do
    depends_on "pkgconf" => :build
    depends_on "glib"
    depends_on "libsecret"
  end

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")

    # Remove incompatible pre-built binaries
    os = OS.kernel_name.downcase
    arch = Hardware::CPU.intel? ? "x64" : Hardware::CPU.arch.to_s
    node_modules = libexec/"lib/node_modules/@google/gemini-cli/node_modules"
    node_modules.glob("{bare-fs,bare-os,bare-url,tree-sitter-bash,node-pty}/prebuilds/*").each do |dir|
      rm_r(dir) if dir.basename.to_s != "#{os}-#{arch}"
    end

    cd node_modules/"@github/keytar" do
      rm_r "prebuilds"
      system "npm", "run", "build"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gemini --version")
    assert_match "Please set an Auth method", shell_output("#{bin}/gemini --prompt Homebrew 2>&1", 41)
  end
end
