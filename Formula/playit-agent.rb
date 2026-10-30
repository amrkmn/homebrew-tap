class PlayitAgent < Formula
  desc "Secure tunnel client to expose local servers via Playit.gg"
  homepage "https://github.com/playit-cloud/playit-agent"
  url "https://github.com/playit-cloud/playit-agent/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "caa1510cc71fc0ea1bf1cd3763c9e136f8d3aa81f5c26f0145a5000d401d4cf5"
  license "BSD-2-Clause"
  head "https://github.com/playit-cloud/playit-agent.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "165ba2c0d8223857337717cb551d81323e72a459576f7e50f95461a9ca005a36"
    sha256 cellar: :any,                 arm64_linux:  "05ee7bd4e406a3501d31079b363fc6acf80739ce12425e4881dde1fb5916e524"
    sha256 cellar: :any,                 x86_64_linux: "73002d0b8f2f4ec8449087a016a6ac202f40b1842713a5f8bbc3df6bab771d30"
  end

  depends_on "rust" => :build

  def install
    # Patch compiled-in default: /run/playit/playitd.sock → #{var}/run/playit/playitd.sock
    inreplace "packages/playit-ipc/src/paths.rs", "/run/playit/playitd.sock", "#{var}/run/playit/playitd.sock"

    system "cargo", "install", *std_cargo_args(path: "packages/playit-cli")
    system "cargo", "install", *std_cargo_args(path: "packages/playitd")
    bin.install_symlink "playit-cli" => "playit"
  end

  service do
    run [opt_bin/"playitd",
         "--secret-path", etc/"playit/playit.toml",
         "--log-path", var/"log/playitd.log"]
    run_type :immediate
    keep_alive true
    log_path var/"log/playitd.log"
    error_log_path var/"log/playitd.error.log"
    working_dir var
  end

  def caveats
    <<~EOS
      To start the playit daemon:
        brew services start #{name}
      After the service is running, run:
        #{opt_bin}/playit setup
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/playit version")
  end
end
