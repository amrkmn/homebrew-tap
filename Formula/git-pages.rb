class GitPages < Formula
  desc "Scalable static site server for Git forges"
  homepage "https://codeberg.org/git-pages/git-pages"
  url "https://codeberg.org/git-pages/git-pages/archive/v0.10.1.tar.gz"
  sha256 "667b141c7865a416c790bdddeb545072bfd857b78fb7df4e85bdee4385bbc1f9"
  license "0BSD"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "7ac9c0b795d1d3dea4456a967bc2e7a02ee4bad2a59f2d0aa1fe9d6c8fcf8506"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "36b91edabcc774122015c2aa52691cd58c1e1247214d2c8decbc5fcb634b699a"
    sha256 cellar: :any,                 x86_64_linux: "d8efd5bffbb91beaaef99cddfaef1ae7fd205a933422370ca43251f7a57bcfc9"
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
