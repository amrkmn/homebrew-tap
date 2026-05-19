class PlayitAgent < Formula
  desc "Secure tunnel client to expose local servers via Playit.gg"
  homepage "https://github.com/playit-cloud/playit-agent"
  url "https://github.com/playit-cloud/playit-agent/archive/refs/tags/v1.0.4.tar.gz"
  sha256 "06620b864c8b41ec6d2a752237936e55da10aafc34f8d5b236b1ff8e8a779596"
  license "BSD-2-Clause"
  head "https://github.com/playit-cloud/playit-agent.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f7aa6659d2c8f691f987c389d9df959e5fbd4901da16ff9b02918d47bb0aff89"
  end

  depends_on "rust" => :build

  def install
    # Patch compiled-in default: /var/run/playitd.sock → #{var}/run/playitd.sock
    inreplace "packages/playit-ipc/src/paths.rs", "/var/run/playitd.sock", "#{var}/run/playitd.sock"

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
