class FastCli < Formula
  desc "Test your download and upload speed using fast.com"
  homepage "https://github.com/sindresorhus/fast-cli"
  url "https://registry.npmjs.org/fast-cli/-/fast-cli-5.0.2.tgz"
  sha256 "94ba89b2bb09edbc24dedddc4d3f0d179240ec7b3d212fcded5f8f73895886b3"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any,                 arm64_tahoe:   "407f4e2d785a936f0a4724d88e2cb3dd1d3d702c11971f0682aeedcdaa789811"
    sha256 cellar: :any,                 arm64_sequoia: "89bf0529ef0b5cf1ab3ae8cea3c9cc1f1c4bca52759ed4954b57027d60e3e325"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "957e8ba90fb25065e8c10a90fa10d47398a6403ed6318d9158dfa6a7054ea590"
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
