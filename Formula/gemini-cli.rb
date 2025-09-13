class GeminiCli < Formula
  desc "Interact with Google Gemini AI models from the command-line"
  homepage "https://github.com/google-gemini/gemini-cli"
  url "https://registry.npmjs.org/@google/gemini-cli/-/gemini-cli-0.4.1.tgz"
  sha256 "4264af52ff410840e81092de13efbb00b3ffd5eef5549919c159fad1d392d906"
  license "Apache-2.0"

  bottle do
    root_url "https://noz.one/v2/pkgs/tap"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0775727e3d0bac6d644c94fd404823aeea77ca1b1054f6c1c339732b893783d7"
  end

  depends_on :linux
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
