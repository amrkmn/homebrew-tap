class Bun < Formula
  desc "Incredibly fast JavaScript runtime, bundler, transpiler and package manager"
  homepage "https://bun.sh"
  url "https://registry.npmjs.org/bun/-/bun-1.3.4.tgz"
  sha256 "c01980fbda488cd38e2a32754fc495c22f9745bad90df528eee241dfa62d6425"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    rebuild 1
    sha256                               arm64_tahoe:   "f72e4cbc8aadcee5476e80911a6c59443f8ce8e5da94d06badb10763d2607251"
    sha256                               arm64_sequoia: "d7dc167e445c06f977cd1b09d86c46e4b9f86a4b24ba142bbde33a6c316a3bd4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "49a36d70d9ee3d0290091e552743fb422b51b0abbca52045cfe56441c83b204b"
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
