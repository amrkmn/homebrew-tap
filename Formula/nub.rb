class Nub < Formula
  desc "Fast TypeScript runtime and package manager that augments Node"
  homepage "https://nubjs.com"
  url "https://github.com/nubjs/nub/archive/refs/tags/v0.11.0.tar.gz"
  sha256 "2bf900d4f0c0a5b963de57689b750adc5c8bb3b72643c97b435ce1ab5375e043"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+\.\d+\.\d+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "65bbbf09d7efd4cec0099397ec3f2b2eaa997a035084344384ea0b72b243b8ee"
    sha256 cellar: :any,                 arm64_linux:  "697dcdf4b8fe3cf3a1ad786a602623c53bd937071587c0435be24f29ca973023"
    sha256 cellar: :any,                 x86_64_linux: "9f47633c629cf47aa519eb388d4ddd1e727cf688fabb29e6083d63fe9283b356"
  end

  depends_on "cmake" => :build
  depends_on "node" => [:build, :test]
  depends_on "rust" => :build

  def install
    # Install at the repo root, where package-lock.json pins versions.
    system "npm", "install", *std_npm_args(prefix: false)

    # The embedded runtime's tree has no parent node_modules to resolve through,
    # so vendor the helpers and web API polyfills it loads.
    %w[
      @js-temporal/polyfill
      @oxc-project/runtime
      @petamoriken/float16
      jsbi
      urlpattern-polyfill
    ].each do |dep|
      (buildpath/"runtime/node_modules"/dep).dirname.mkpath
      cp_r buildpath/"node_modules"/dep, buildpath/"runtime/node_modules"/dep
    end

    cd "crates/nub-native" do
      system "cargo", "build", "--release", "--lib"
    end
    mkdir_p "runtime/addons"
    cp shared_library("target/release/libnub_native"), "runtime/addons/nub-native.node"

    system "cargo", "install", *std_cargo_args(path: "crates/nub-cli", features: ["embed-runtime"])
    bin.install_symlink bin/"nub" => "nubx"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/nub --version")
    assert_match "Usage: nub nubx", shell_output("#{bin}/nubx --help")

    (testpath/"package.json").write <<~JSON
      {
        "name": "test-app",
        "version": "1.0.0"
      }
    JSON

    # Transpile a file that loads a helper from the vendored runtime node_modules.
    # Legacy decorators are down-levelled on every Node, covering the embedded runtime.
    (testpath/"tsconfig.json").write <<~JSON
      {"compilerOptions": {"experimentalDecorators": true, "emitDecoratorMetadata": true}}
    JSON
    (testpath/"decorated.ts").write <<~TYPESCRIPT
      function log(target: any, key: string, descriptor: PropertyDescriptor) { return descriptor; }
      class Greeter { @log greet(): string { return "hello nub"; } }
      console.log(new Greeter().greet());
    TYPESCRIPT
    assert_equal "hello nub", shell_output("#{bin}/nub decorated.ts").strip

    system bin/"nub", "config", "set", "registry", "https://registry.npmjs.org"
    assert_match "https://registry.npmjs.org", shell_output("#{bin}/nub config get registry")
  end
end
