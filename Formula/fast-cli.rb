class FastCli < Formula
  desc "Test your download and upload speed using fast.com"
  homepage "https://github.com/sindresorhus/fast-cli"
  url "https://registry.npmjs.org/fast-cli/-/fast-cli-6.0.0.tgz"
  sha256 "7b0026d3bfdea5e236abb2ee5bbef8702d1daf02554262cb2fc343e4a6e19e7c"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9b12a7b85a49c859ca410db42cea8a422064bb1e68a00191f06471d4e89ef1d5"
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
