class GitPages < Formula
  desc "Scalable static site server for Git forges"
  homepage "https://codeberg.org/git-pages/git-pages"
  url "https://codeberg.org/git-pages/git-pages/archive/v0.10.1.tar.gz"
  sha256 "667b141c7865a416c790bdddeb545072bfd857b78fb7df4e85bdee4385bbc1f9"
  license "0BSD"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "97a17f21d58496a1ccc96ca833b66244f190d8a5af9881980684b9d0b5a32c91"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "104c3ca29b7f2b159679ad8b1067086fdadcc9462f34b20669f2906dda0d8f2e"
    sha256 cellar: :any,                 x86_64_linux: "4b6be8054344fe475358975a09cd358314d05ff2e52e3375666e22bdb3d0491c"
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
