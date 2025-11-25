class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.109.tgz"
  sha256 "ce7e3cd669138483e6d960e5fcdf617d6c90166998673e7aab5f534cdfd5c17f"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "c1978a264520b0ce828201c8d0ae37f0ce79a4eb39620a761904d0202239a6da"
    sha256                               arm64_sequoia: "313981fde7130c6dc6685edce7e0c55c8a9ab2dd16313e2c6c9229d9fc1e7327"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "65feee00005c1acb5ae630f42dea0e34fb95bdbee85cfb8dac08d86b5a9151ac"
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
