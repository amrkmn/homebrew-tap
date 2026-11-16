class GitPages < Formula
  desc "Scalable static site server for Git forges"
  homepage "https://codeberg.org/git-pages/git-pages"
  url "https://codeberg.org/git-pages/git-pages/archive/v0.10.2.tar.gz"
  sha256 "d0b7e5c1f1a34bfedcb2c307d0be86ce6fc6a7c69116a591a4558835f4d038de"
  license "0BSD"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "075959eb7c4fa89c6fb3f4e69e4f3b3e9646eae68bc7bb9dc1ed499b7b52b101"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "505ca5d9de8e42a971e2a0574760fb940b2b93e18d68cfca31b166625ff3a934"
    sha256 cellar: :any,                 x86_64_linux: "c93874f76b37e8bfc4b5811d3d78ab242508597637f8d39042911d941c18ea96"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    mkdir_p "data"
    port = free_port

    (testpath/"config.toml").write <<~TOML
      [server]
      pages = "tcp/localhost:#{port}"
    TOML

    ENV["PAGES_INSECURE"] = "1"

    spawn bin/"git-pages"

    sleep 2
    system "curl", "http://127.0.0.1:#{port}", "-X", "PUT", "-d", "https://codeberg.org/git-pages/git-pages.git"

    sleep 2
    assert_equal "It works!\n", shell_output("curl http://127.0.0.1:#{port}")
  end
end
