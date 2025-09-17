class Bun < Formula
  desc "Blazing fast JS runtime, bundler, tester & package manager in one"
  homepage "https://bun.sh/"
  url "https://registry.npmjs.org/bun/-/bun-1.2.22.tgz"
  sha256 "4fa9880e1d552af2348d9b35024a0627f6ef4289bd272dd7dcfe4cbe1b010785"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fb7dda1699a656549eeb6013509aa9fbd35d301284cc559ff70d237ac75ec243"
  end

  depends_on :linux
  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
    generate_completions_from_executable(bin/"bun", "completions")
  end

  def post_install
    avx2 = Hardware::CPU.features.include?(:avx2)
    is_musl = File.exist?("/etc/alpine-release")

    keep = if avx2 && is_musl
      "bun-linux-x64-musl"
    elsif avx2 && !is_musl
      "bun-linux-x64"
    elsif !avx2 && is_musl
      "bun-linux-x64-musl-baseline"
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
