class Bun < Formula
  desc "Incredibly fast JavaScript runtime, bundler, transpiler and package manager"
  homepage "https://bun.sh"
  url "https://registry.npmjs.org/bun/-/bun-1.3.2.tgz"
  sha256 "d6b0065aead1df28a041f3f47d915c31087f09c8605dcffb28c3808b8eabfbb2"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "7eca52e2ee1aafee5cb78050665bc4e92d8ff03444a88d4d8ce12592c3bd5027"
    sha256                               arm64_sequoia: "af6347af29d362bea0c24976ab2ed86e4af3767d539627a3065039f7a521cc49"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1276b63ad842e8b9ba84627690c1fcf2d9a826b586f3a8c494b8a2e67cfadf53"
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

    ENV["BUN_INSTALL"] = bin.to_s
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
