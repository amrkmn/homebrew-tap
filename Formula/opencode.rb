class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.106.tgz"
  sha256 "4bf7318bff006d35906b3ab243c21c3b860e98b5b13b3f62a58a5db5cc56f9a5"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "97e33f9ab1118c28ac5676960ef6ffd60fec9fecd57613b5df87033716950142"
    sha256                               arm64_sequoia: "a6c9439c117558ee24aed4aac960f0731b44b033a0bcf00ddc9380a2542a8687"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6e6b593ca45f86db390efbd4abe73969538d9794b92a29f59fa6fe95a3422557"
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
