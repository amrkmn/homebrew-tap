class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.87.0.tgz"
  sha256 "8cb356b54c5ac7501f657073b48fa59843b97a78c28838d7b5a8917c6b09d980"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "e3c4fc890cfca3500a337acc0be7b863d6a6366ef41a493085d65a4b4988725e"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "3dca5083909be8e5751c981da25a46c0333a569cbdbf4e172551fefb3216f94e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "155a045237d841caf30224accd133e5c700ea86e50163258c60fdf76c9a71e3a"
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
