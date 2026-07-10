class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.84.0.tgz"
  sha256 "b76d2b870076eeacfd2dc982057e48a0d27bc83e72397ccc58ea14ac3a614ce9"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "d547abf70b76a589e4c3563dd06becc3c320f0b8f099bb10d06be5659f3b8b11"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "465f60cb57dacea9838e48351d3ff6f7410f0beb1c84a77f0706f9481dda30ab"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b6b76af1e6457070a1ff805cab45a8bd1d0e28bcc52aa5cb349d66056cb2cb63"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]

    generate_completions_from_executable(bin/"crush", "completion")
  end

  test do
    assert_match "crush version v#{version}", shell_output("#{bin}/crush --version")
  end
end
