class PlayitAgent < Formula
  desc "Secure tunnel client to expose local servers via Playit.gg"
  homepage "https://github.com/playit-cloud/playit-agent"
  url "https://github.com/playit-cloud/playit-agent/archive/refs/tags/v1.0.10.tar.gz"
  sha256 "52b431a861c143f3fc78bfce8d7d5862bf865bc88da584cafb62a5fec39c0df4"
  license "BSD-2-Clause"
  head "https://github.com/playit-cloud/playit-agent.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any, x86_64_linux: "91c960ba59a03f249dab658b75a096cd1df3c7469e31f1bdef7f2f35148bc2c0"
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
