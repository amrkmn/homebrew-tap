class Restic < Formula
  desc "Fast, secure, efficient backup program"
  homepage "https://restic.net"
  url "https://github.com/restic/restic/archive/refs/tags/v0.19.1.tar.gz"
  sha256 "bb9b1a19040744d26d8a79be029d4e6b189c45ccc9d8831d7fe367d3c33df725"
  license "BSD-2-Clause"
  head "https://github.com/restic/restic.git", branch: "master"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "917ac40e5685d69064d22c1b992a154b0d67eef1ab38fc4bc4e119236d3946c0"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "ac3d6730d38a0ef52cdd0b656cd9a7a5a4df4b36e5b585de0958fed050750f41"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "37a8f47fa1c5bdaf4885663236f812bb17947d3e7440b86de859c9951d53e29a"
  end

  depends_on "go" => :build

  def install
    system "go", "run", "build.go"

    mkdir "completions"
    system "./restic", "generate", "--bash-completion", "completions/restic"
    system "./restic", "generate", "--zsh-completion", "completions/_restic"
    system "./restic", "generate", "--fish-completion", "completions/restic.fish"

    mkdir "man"
    system "./restic", "generate", "--man", "man"

    bin.install "restic"
    bash_completion.install "completions/restic"
    zsh_completion.install "completions/_restic"
    fish_completion.install "completions/restic.fish"
    man1.install Dir["man/*.1"]
  end

  test do
    mkdir testpath/"restic_repo"
    ENV["RESTIC_REPOSITORY"] = testpath/"restic_repo"
    ENV["RESTIC_PASSWORD"] = "foo"

    (testpath/"testfile").write("This is a testfile")

    system bin/"restic", "init"
    system bin/"restic", "backup", "testfile"

    system bin/"restic", "restore", "latest", "-t", "#{testpath}/restore"
    assert compare_file "testfile", "#{testpath}/restore/testfile"
  end
end
