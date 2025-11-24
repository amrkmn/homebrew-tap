class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.107.tgz"
  sha256 "590e4ad65b21b94db31fb091477554e199ca9195cd15b8597dd2f5dcbd8b0eca"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "f187771e27899c1587d08297ebaa41f82c2db6715715b7d30abf5b084df978f6"
    sha256                               arm64_sequoia: "51cb1cf172920dc4e4a0d9242ebc3f0714210fa5044dc0b87473edf8487b8cdc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d4d946dffb8f8cac47001c3b47bf287173beef60b860ff7ce443d964a9897dc9"
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
