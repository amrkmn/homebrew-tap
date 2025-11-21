class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.83.tgz"
  sha256 "ce3ba3854aeec82225c3022e09b10decf5a049754890cac10f20a76b83495b41"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "013ff7567f0c704b82e797b6b786820d015e679ea2bc0bc2d249850806bea7bf"
    sha256                               arm64_sequoia: "b11b8907e877cdcd2547ed9b55f4ee728c735400224c1dfc06798939ddb16394"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "71a9a1b1dee21239d19a3a8416c7e8fddc078bb0c832ec4b9e92520a7ee2c6eb"
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
