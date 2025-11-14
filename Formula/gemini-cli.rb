class GeminiCli < Formula
  desc "Interact with Google Gemini AI models from the command-line"
  homepage "https://github.com/google-gemini/gemini-cli"
  url "https://registry.npmjs.org/@google/gemini-cli/-/gemini-cli-0.15.1.tgz"
  sha256 "3f12613c07219c0d6ec745a3fca448228dfb994d49ace3d8e3ae54a7bbfe2841"
  license "Apache-2.0"

  livecheck do
    url "https://registry.npmjs.org/@google/gemini-cli/latest"
    strategy :json do |json|
      json["version"]
    end
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "8267b6f4c6a7de25eddaa5a2bb8fe0a995a4e88deaf74da7eeb3c2bd889d9fe7"
    sha256                               arm64_sequoia: "7929f590679876cbc22f960553142257a2b04baf8ff02a7bc354fc87ff7aaa35"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2a0d35c66a3ae3da38c86164605d7f9dbf120e793ec38eaf8b48cd655ba199b6"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]

    # Remove incompatible pre-built binaries
    os = OS.kernel_name.downcase
    arch = Hardware::CPU.intel? ? "x64" : Hardware::CPU.arch.to_s
    node_modules = libexec/"lib/node_modules/@google/gemini-cli/node_modules"
    libexec.glob("#{node_modules}/tree-sitter-bash/prebuilds/*")
           .each { |dir| rm_r(dir) if dir.basename.to_s != "#{os}-#{arch}" }
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gemini --version")
    assert_match "Please set an Auth method", shell_output("#{bin}/gemini --prompt Homebrew 2>&1", 1)
  end
end
