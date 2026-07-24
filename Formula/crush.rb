class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.87.0.tgz"
  sha256 "8cb356b54c5ac7501f657073b48fa59843b97a78c28838d7b5a8917c6b09d980"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "276f718f677308f675189240826d37598d9a181b360787d1d6cb9567ea2308e6"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "4dabf874d68e39b067a03676ed7a7180dd4ec0d6c4429850cb6c56162129eeeb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a85fe9820bbd26c1bd854e444304a175c3125527b138914866fd90fe1eaa07c0"
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
