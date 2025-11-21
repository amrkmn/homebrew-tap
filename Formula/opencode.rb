class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.86.tgz"
  sha256 "1edf3b9ea19162343f1677d61ad3cfba36e471cb8d9a071ee8e7aca5add802d4"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "7ad498456819d7df82ebe84acf4b34543ac20d798ee9a82fb7cf50537a3b4596"
    sha256                               arm64_sequoia: "1ab8e0526eeccb462c4f333f7756669ef09eb3e466735a57d263b02dfe9d5371"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3f2bcc3c589e67b187aa76d86866b2f5de8fb88e6ced0e0d0a801eb105bd81f8"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]

    # Remove binaries for other architectures, `-musl`, `-baseline`, and `-baseline-musl`
    arch = Hardware::CPU.arm? ? "arm64" : "x64"
    os = OS.linux? ? "linux" : "darwin"
    (libexec/"lib/node_modules/opencode-ai/node_modules").children.each do |d|
      next unless d.directory?

      rm_r d if d.basename.to_s != "opencode-#{os}-#{arch}"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/opencode --version")
    assert_match "opencode", shell_output("#{bin}/opencode models")
  end
end
