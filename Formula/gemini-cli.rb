class GeminiCli < Formula
  desc "Interact with Google Gemini AI models from the command-line"
  homepage "https://github.com/google-gemini/gemini-cli"
  url "https://registry.npmjs.org/@google/gemini-cli/-/gemini-cli-0.71.1.tgz"
  sha256 "3381cebd8a58b43ab161fd9302d5b1f097ab2eb010278176e8afd3533d1c98bc"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    manifest_sha256 "0c90cd14d50f7a1d3534dcef7b815a98607577428306fa47ac0db7f25de9b9c9"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "51e31de1fd613dbd9dcb2d54a8a18ba3a082baf1c79102ae500286da992c8fca"
    sha256 cellar: :any,                 arm64_linux:  "6276b130e3a1d4b4e25578bdb850ca3d6a7589ea72f114663d55b5d3ca8baa90"
    sha256 cellar: :any,                 x86_64_linux: "37201ee75bc96ac02c294dfc424fb77dadb017de3c048c9191d18e87e88a61ff"
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
