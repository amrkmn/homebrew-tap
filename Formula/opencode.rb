class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.68.tgz"
  sha256 "866c8b3d4e12844e90d2a88f9c4ef97dbd11b25aaab0973fe5523f7deb94485e"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "f5ddf2b9bb020f4809b2bdd2bd34037caedf67e30af4eaa1492cce35179113f0"
    sha256                               arm64_sequoia: "683779581882be57015f55441368c7ccecb77d47973a6097f41685ad40037fe8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "54354338389832e9b28d78e7a08bd5164d185c492a5591fb577320ff8d89b9df"
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
