class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.23.tgz"
  sha256 "575b503168c525f93a04bebee6114e22521be705a80031d8dc58fd035990cd93"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "2dad851ecd39d27ec2944eec08794f6d690b8c1611547919ae9576e6d69e76ac"
    sha256                               arm64_sequoia: "29c692b3bf6422b18d64a9f69e9e1ec6f01f368035fbfd13ba0461260df821ab"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0af33110031e5e8051babef556bf24c0886674b04d3561c68aee4514300008e2"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/opencode --version")
    assert_match "opencode", shell_output("#{bin}/opencode models")
  end
end
