class GeminiCli < Formula
  desc "Interact with Google Gemini AI models from the command-line"
  homepage "https://github.com/google-gemini/gemini-cli"
  url "https://registry.npmjs.org/@google/gemini-cli/-/gemini-cli-0.14.0.tgz"
  sha256 "366027d2c6fd5afaf2a7ac08a00b7b73fe3eedef10210c1576896c4cde8dadcd"
  license "Apache-2.0"

  livecheck do
    url "https://registry.npmjs.org/@google/gemini-cli/latest"
    strategy :json do |json|
      json["version"]
    end
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "29fa68ddecded85bc7f51f08349443098df0558171847853c58597c5e16d2fb8"
    sha256                               arm64_sequoia: "e2d58070ff97f2e152fe37f38946d81252b2a5a10587703f1016773d2d0ab2e9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a3ba996b4c33c40fd044cb29c8affea9e4dd3ae00206f9944e3cfddb2c0aea0b"
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
