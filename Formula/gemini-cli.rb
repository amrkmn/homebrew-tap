class GeminiCli < Formula
  desc "Interact with Google Gemini AI models from the command-line"
  homepage "https://github.com/google-gemini/gemini-cli"
  url "https://registry.npmjs.org/@google/gemini-cli/-/gemini-cli-0.7.0-nightly.20250918.2722473a.tgz"
  version "0.7.0-nightly.20250918.2722473a"
  sha256 "f85ddd2e34a97ac0fee0c5c916a15fc9615bd518a195f49cfa0ca2a81f7c394e"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "b7480898af6d1be900f8a74a4959a5da38edee5a764ad7ba7eeda17f53bbc3d0"
    sha256                               arm64_sequoia: "11f9c788bc3c983ee9eab5e49b958de8fa348a5b35f905a7a95bf6640200da82"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "37c7b5fbb5b15bd3b21272d40b055aec874ccfb54323f8f6e9d24adf37efac42"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gemini --version")
    assert_match "Please set an Auth method", shell_output("#{bin}/gemini --prompt Homebrew 2>&1", 1)
  end
end
