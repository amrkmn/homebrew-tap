class Nub < Formula
  desc "Fast TypeScript runtime and package manager that augments Node"
  homepage "https://nubjs.com"
  url "https://github.com/nubjs/nub/archive/refs/tags/v0.9.3.tar.gz"
  sha256 "a59fa2e65d500eace079aa5ee0168af57fac71e2a2dd168dbb6ff11a8d163ffb"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+\.\d+\.\d+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "612cc61d04b9b5c2c90b8fb171c029de8dfd82408b7c3acdb29866c93d51a3da"
    sha256 cellar: :any,                 arm64_linux:  "b192fef3389a30898e7bacf4cfa3c05ac3f86b89091f38298707a85612f1e467"
    sha256 cellar: :any,                 x86_64_linux: "05d744dc45850871ae205c0bdb05a8652c222bf6d92c98dc4abdc66f79f3449f"
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
