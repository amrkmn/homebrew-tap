class Restic < Formula
  desc "Fast, secure, efficient backup program"
  homepage "https://restic.net"
  url "https://github.com/restic/restic/archive/refs/tags/v0.18.0.tar.gz"
  sha256 "fc068d7fdd80dd6a968b57128d736b8c6147aa23bcba584c925eb73832f6523e"
  license "BSD-2-Clause"
  head "https://github.com/restic/restic.git", branch: "master"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "030e7d580ea78b7a513dd3c1440374ea7192815e0516ebe70fd0c9738ceaab52"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ad760addf5b5cb45fdaf4db30d20a81f20f12198d0159ec987566ca181ca4e14"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "046ddca094edb8e543f030c2b1c171f1eb9ccd2790c57c4c3f52013a57c267b5"
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
