class Bun < Formula
  desc "Blazing fast JS runtime, bundler, tester & package manager in one"
  homepage "https://bun.sh/"
  url "https://registry.npmjs.org/bun/-/bun-1.2.22.tgz"
  sha256 "4fa9880e1d552af2348d9b35024a0627f6ef4289bd272dd7dcfe4cbe1b010785"
  license "MIT"

  depends_on :linux
  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
    ENV["BUN_INSTALL"] = bin.to_s
    generate_completions_from_executable(bin/"bun", "completions")
  end

  def post_install
    keep = if Hardware::CPU.avx2?
      "bun-linux-x64"
    else
      "bun-linux-x64-baseline"
    end

    Dir["#{libexec}/lib/node_modules/bun/node_modules/@oven/*"].each do |dir|
      rm_r(dir) unless dir.end_with?(keep)
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bun --version")
  end
end
