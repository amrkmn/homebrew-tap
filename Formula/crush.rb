class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.17.0.tgz"
  sha256 "e2f95cbfc12740ebac3015012328c00b8121510f4f082e7293fd051aadef2306"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "c04e4ec2b9494c7dd94f74d533bd9c1e4917fe6f440fc9218f5a474953298b9c"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "762c3a5ab0fe483f9426935ad93b798de0e89d24fe82b02a8e66de42e88fa15c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ed3b94ea6c37d6dd63aa6b2fd002021d65d3c5ce66cdbd918f660b715c545911"
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
