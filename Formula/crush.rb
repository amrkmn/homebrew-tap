class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.13.2.tgz"
  sha256 "62e7ce442a63d0991a2216f513f03112b748f6cb86f97c787ae2bbfa8b9f7163"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "c6a57dea5201143cfdaa4f49ed064685083c8f6bdd5b1868aee2b4bd4e29713e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f54668c42068480f0778e77f023528992145984dfe7ea44b421a316295401e10"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f69eae472297eb02b9e3f7e8d63447dd7081ccc6c1f342ee8e3659c175dfcad4"
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
