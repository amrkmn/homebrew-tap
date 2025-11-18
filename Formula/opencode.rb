class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.76.tgz"
  sha256 "71f47ad78ec74de522e07ebc03dff11ef47ecdf33e822ceacb8ad9bac35a2e63"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "b1db1ffa43adb5713f3575a62ef8012bed689fd027ae0a6bf5c5b9693d4e6792"
    sha256                               arm64_sequoia: "6e569bf02b1a298f3540b45df55bf344f7a135e6148a16703c9d89c173fa2103"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8b9759f274843abe85bff30f19dbd12f1d35d8fd8fc6515fdff9cdba055e9e00"
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
