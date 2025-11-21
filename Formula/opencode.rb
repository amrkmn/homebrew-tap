class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.86.tgz"
  sha256 "1edf3b9ea19162343f1677d61ad3cfba36e471cb8d9a071ee8e7aca5add802d4"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "b1641f36f8d7ec7a87591539b7c9a2a1452f8358f3c25d57a3cb37dc52e9b82d"
    sha256                               arm64_sequoia: "0cc568a6afb63acf84de03e00c46b912ca39bed5d2a590f71a153aed268d5350"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c7c21416dac8d8d0c37cf720ce715d8eef0ea8045cedf9710c6d8b71a0eb63f6"
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
