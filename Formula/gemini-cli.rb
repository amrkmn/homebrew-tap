class GeminiCli < Formula
  desc "Interact with Google Gemini AI models from the command-line"
  homepage "https://github.com/google-gemini/gemini-cli"
  url "https://registry.npmjs.org/@google/gemini-cli/-/gemini-cli-0.71.1.tgz"
  sha256 "3381cebd8a58b43ab161fd9302d5b1f097ab2eb010278176e8afd3533d1c98bc"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    manifest_sha256 "79075602c299a87f8841235b94a818646078da2c0914f43ae4e162f5cac91e9b"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "feecd3d718b7c0ad81bc3e3f33ff8ee1408ec28de911ef99ee47dce8bdbffedd"
    sha256 cellar: :any,                 arm64_linux:  "02c83409b31e8b204d7dcd86128024a82f52d8b8e408fa09a49510493236842c"
    sha256 cellar: :any,                 x86_64_linux: "38db79e0022cd7f4c6c8c1526f8a320152a44c667efa0e353e0e907b5fe386f3"
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
