class Bun < Formula
  desc "Incredibly fast JavaScript runtime, bundler, and package manager"
  homepage "https://bun.sh/"
  url "https://registry.npmjs.org/bun/-/bun-1.3.5.tgz"
  sha256 "af96f357e90847fcb252b69d542e7790cf1c9927f57a6a0162e9acffb7b5f7eb"
  license "MIT"

  depends_on "node" => :build

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]

    arch = Hardware::CPU.arm? ? "aarch64" : "x64"
    os = OS.linux? ? "linux" : "darwin"

    (libexec/"lib/node_modules/bun/node_modules/@oven").children.each do |d|
      next unless d.directory?

      rm_r d if d.basename.to_s != "bun-#{os}-#{arch}"
    end
  end

  test do
    system bin/"bun", "--version"
    assert_match version.to_s, shell_output("#{bin}/bun --version")
  end
end
