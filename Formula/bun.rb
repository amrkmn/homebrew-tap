class Bun < Formula
  desc "Incredibly fast JavaScript runtime, bundler, transpiler and package manager"
  homepage "https://bun.sh"
  url "https://registry.npmjs.org/bun/-/bun-1.3.2.tgz"
  sha256 "d6b0065aead1df28a041f3f47d915c31087f09c8605dcffb28c3808b8eabfbb2"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    rebuild 1
    sha256                               arm64_tahoe:   "d7431c1e3357c87a0f02b07b07ff272f805cb0f714896c279cabedd599f147cd"
    sha256                               arm64_sequoia: "db9af193bad4d5d4afbd46a1ed89bafabc4900ccaafd8e8cce543f8bcebdec1c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4b3490bc0fc743ca1d82d90c79f878438c974d73b298472c45c54cc92ae4e1cf"
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
