class PlayitAgent < Formula
  desc "Secure tunnel client to expose local servers via Playit.gg"
  homepage "https://github.com/playit-cloud/playit-agent"
  url "https://github.com/playit-cloud/playit-agent/archive/refs/tags/v2.0.2.tar.gz"
  sha256 "19f796aa59a9f5c4691b05b62c565df99ac9479a55a381040742d975981409a9"
  license "BSD-2-Clause"
  head "https://github.com/playit-cloud/playit-agent.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "c9bec72ff638ab4c9d76377c62b533d0dcebfbd6a849aa935865723f7c06fa33"
    sha256 cellar: :any,                 arm64_linux:  "4a249014337f2d1c189cea28146e319256d203b4e980b8b3898ac9143f4661de"
    sha256 cellar: :any,                 x86_64_linux: "8cdfcaef45707f7ca1f4ade2922932456d43b5afba611d6b833bac993aca73f0"
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
