class PlayitAgent < Formula
  desc "Secure tunnel client to expose local servers via Playit.gg"
  homepage "https://github.com/playit-cloud/playit-agent"
  url "https://github.com/playit-cloud/playit-agent/archive/refs/tags/v1.0.3.tar.gz"
  sha256 "a8917d9e85012e4b52d4aa7c4f432188a624198da71a5df72ca136e2e3a47287"
  license "BSD-2-Clause"
  head "https://github.com/playit-cloud/playit-agent.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9c71a6469ded3530cfc36e417fe87f232cde9f90070f2ea8bd8cfb31e3f54875"
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
