class Bun < Formula
  desc "Blazing fast JS runtime, bundler, tester & package manager in one"
  homepage "https://bun.sh/"
  url "https://registry.npmjs.org/bun/-/bun-1.2.22.tgz"
  sha256 "4cc42e5ef2fcfd564352d613ea639282c930f81230de03227765f79735c36e17"
  license "MIT"

  depends_on :linux
  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
    ENV["BUN_INSTALL"] = bin.to_s
    generate_completions_from_executable(bin/"bun", "completions")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bun --version")
  end
end
