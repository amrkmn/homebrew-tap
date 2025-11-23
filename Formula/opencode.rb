class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.106.tgz"
  sha256 "4bf7318bff006d35906b3ab243c21c3b860e98b5b13b3f62a58a5db5cc56f9a5"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "2400e0a19e24108fdcffa466d2dda046dc9b801e421f1d811ee9e028f04bc62b"
    sha256                               arm64_sequoia: "404338f00d03379018c49eb80ebaaa7d1c0a8bfe644cb75309f63ae998bff1b1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "91f1f23057810d62f3266b36aa9f961e17f2c4fd17a580daf6ea5dab879cc1dd"
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
