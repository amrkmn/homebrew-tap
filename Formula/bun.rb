class Bun < Formula
  desc "Incredibly fast JavaScript runtime, bundler, transpiler and package manager"
  homepage "https://bun.sh"
  url "https://registry.npmjs.org/bun/-/bun-1.3.2.tgz"
  sha256 "d6b0065aead1df28a041f3f47d915c31087f09c8605dcffb28c3808b8eabfbb2"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    rebuild 2
    sha256                               arm64_tahoe:   "4eb379c65c5accb4ce62932a9b903b3c017ed40a508065d6e1d3679b1d87e1eb"
    sha256                               arm64_sequoia: "b4c9c4765e1db7f3c47700db40d402091a1c0a65c4e79befd81daaf5f1292f91"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c91ededdbee21b9db79aa8f66e20554102cda9f13140d1d27eb6382481016bbf"
  end

  depends_on "node" => [:build, :test]

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]

    # Remove binaries for other architectures, `-musl`, `-baseline`, and `-baseline-musl`
    arch = Hardware::CPU.arm? ? "aarch64" : "x64"
    os = OS.linux? ? "linux" : "darwin"
    (libexec/"lib/node_modules/bun/node_modules/@oven").children.each do |d|
      next unless d.directory?

      rm_r d if d.basename.to_s != "bun-#{os}-#{arch}"
    end

    ENV["BUN_INSTALL"] = bin
    generate_completions_from_executable(bin/"bun", "completions")
  end

  def caveats
    <<~EOS
      bun requires a Node installation to function. You can install one with:
        brew install node
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bun -v")
  end
end
