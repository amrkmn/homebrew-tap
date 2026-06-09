class Restic < Formula
  desc "Fast, secure, efficient backup program"
  homepage "https://restic.net"
  url "https://github.com/restic/restic/archive/refs/tags/v0.19.0.tar.gz"
  sha256 "800779b6c4c2396971c0567b09ccdd435e03155e1a0ec94e8bbf3d98641a8bc2"
  license "BSD-2-Clause"
  head "https://github.com/restic/restic.git", branch: "master"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "3bb323395d703527ab283cdb0a90c8bfde100623d9bbc0f9065bcf34023285a1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "523867bea0f34953695e7698f34828308aa23f70db300054c009d25dcd23bf6f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c4800ebeca10b52d656f2f98d080ad8bbdb23efbe502353ca547b0adba21c965"
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
