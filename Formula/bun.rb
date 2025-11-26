class Bun < Formula
  desc "Incredibly fast JavaScript runtime, bundler, transpiler and package manager"
  homepage "https://bun.sh"
  url "https://registry.npmjs.org/bun/-/bun-1.3.3.tgz"
  sha256 "f8ce8a65b3aa628630267f56c241da8e9062dd78f88025f27ab10882f162e334"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "6fccbd72167903cb1c38a30ea43b67e0e76f350c4339c38855e606961449a44c"
    sha256                               arm64_sequoia: "ff85fd610dd7320826ff9a599d903683c271e01e2ab9280ef842ecce9d62e38b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ade9c7b539d878e9972f270946b48f02a00796c0f71fd7cb92fab897fac67656"
  end

  depends_on "node" => [:build, :test]

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]

    arch = Hardware::CPU.arm? ? "aarch64" : "x64"
    os = OS.linux? ? "linux" : "darwin"
    (libexec/"lib/node_modules/bun/node_modules/@oven").children.each do |d|
      next unless d.directory?

      rm_r d if d.basename.to_s != "bun-#{os}-#{arch}"
    end

    generate_completions_from_executable(libexec/"bin/bun", "completions")
  end

  def caveats
    <<~EOS
      bun requires a Node installation to function. You can install one with:
        brew install node

      To use bun, add the following to your shell profile (~/.zshrc, ~/.bashrc, etc.):
        export BUN_INSTALL="$HOME/.bun"
        export PATH="$BUN_INSTALL/bin:$PATH"
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bun -v")
  end
end
