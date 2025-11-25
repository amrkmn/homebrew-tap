class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.112.tgz"
  sha256 "555cd4636a528f0da567d00c1e1260da5e80c11b5c90026cc90a91e5b21259bc"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "07364349f64d167817f1452b7b52247a77469deec75b6cc72f1256d8d650a05c"
    sha256                               arm64_sequoia: "f6055f9e016ccd18e83fda99e1334a1f5c91305baa46c181ad7340efdf10bd10"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9343f0a21dfff8183bd6b484cdecb78a4a02513ce56a83cc5cbab48b3baf54b5"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]

    # Remove binaries for other architectures, `-musl`, `-baseline`, and `-baseline-musl`
    arch = Hardware::CPU.arm? ? "arm64" : "x64"
    os = OS.linux? ? "linux" : "darwin"
    (libexec/"lib/node_modules/opencode-ai/node_modules").children.each do |d|
      next unless d.directory?

      rm_r d if d.basename.to_s != "opencode-#{os}-#{arch}"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/opencode --version")
    assert_match "opencode", shell_output("#{bin}/opencode models")
  end
end
