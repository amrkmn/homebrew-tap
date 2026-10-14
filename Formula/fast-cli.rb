class FastCli < Formula
  desc "Test your download and upload speed using fast.com"
  homepage "https://github.com/sindresorhus/fast-cli"
  url "https://registry.npmjs.org/fast-cli/-/fast-cli-6.0.0.tgz"
  sha256 "7b0026d3bfdea5e236abb2ee5bbef8702d1daf02554262cb2fc343e4a6e19e7c"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "5492f892c78e10da61b53a48544307f48ae0b3ee0c9cb182e6bbd03af050d3dd"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "bd23d98eb4baca8071d24b4bd99ee1ea04b48a3961d40a5808f104a4f984cd7c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ccb22928b2e3f800adf5c2ceeb27ebea1588f67539c1e50107fbcca7579308e3"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]

    # Remove non-native architecture prebuilds
    arch = Hardware::CPU.arm? ? "arm64" : "x64"
    os = OS.linux? ? "linux" : "darwin"
    (libexec/"lib/node_modules/fast-cli/node_modules").glob("*/prebuilds/*").each do |dir|
      rm_r dir if dir.basename.to_s != "#{os}-#{arch}"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/fast --version")
  end
end
