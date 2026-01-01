class FastCli < Formula
  desc "Test your download and upload speed using fast.com"
  homepage "https://github.com/sindresorhus/fast-cli"
  url "https://registry.npmjs.org/fast-cli/-/fast-cli-5.1.0.tgz"
  sha256 "5bb4b946dd387089be225a31156a2a8cea968b6a91d14cf59f0e63057705d95a"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4a38143f10ea11e527e4678733fa2dd0d2402fb27e4c7dd1181f8b005569277a"
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
