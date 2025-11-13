class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.18.1.tgz"
  sha256 "6b70a2fef74f7b8adbe6350355b8299db592a8232adc00f9676cb630719fa6ba"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "4547182005067512b729da7887517858a5d37ee2230dd7e5835f12716c25e267"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e301a3d9fb2961e916407987096e679c5a506f8132ca233c8f2be086dca6484d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "57430727ad811a5f4772494b33b236ae4690a7aa0bcf5d75c845f848553e3d68"
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
