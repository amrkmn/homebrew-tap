class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai"
  url "https://github.com/anomalyco/opencode/archive/refs/tags/v2.3.2.tar.gz"
  sha256 "de809cbf853ad98374961c525bd124e3e86bd285264b69fae53943a6e2dcdd5d"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 arm64_tahoe:  "1329d4573efe8e6eb9c899cf86cfe29ee85124caed512f1afd0cab4be5102222"
    sha256 arm64_linux:  "06c89ae11e20366f8332852c9fc7ad56dda173497c3171f0188c52c97660f79f"
    sha256 x86_64_linux: "113d7d72cba1abf766cff18aa3c19a5ca77551668af9078ed47ce350c2f90d46"
  end

  depends_on "bun" => :build
  depends_on "python@3.15" => :build
  depends_on "rust" => :build
  depends_on "zig@0.16" => :build
  depends_on "ripgrep"

  on_linux do
    depends_on "icu4c@79"
  end

  # opencode-pty's build.rs requires a git checkout of the revision in its `ghostty-revision` file
  resource "ghostty" do
    url "https://github.com/ghostty-org/ghostty.git",
        revision: "ab0b9da9e88fcb4b0533a1854e84628f663930af"
    version "ab0b9da9e88fcb4b0533a1854e84628f663930af"

    livecheck do
      url "https://raw.githubusercontent.com/anomalyco/opencode/refs/tags/v#{LATEST_VERSION}/packages/process-daemon/ghostty-revision"
      regex(/^(\h{40})$/i)
    end
  end

  # Ghostty's `translate_c` dependency pins this archive in its build.zig.zon.
  # Zig fails to fetch it on macOS CI with `HttpHeadersOversize`.
  resource "aro" do
    url "https://github.com/vancluever/arocc/archive/ecbc5c799574e0da2758a961b12efa586007f03c.tar.gz"
    sha256 "aa54487bd727e8fa36744ff0a824dedb2f4ca45f4c2d4d9d2437cf5fd3d0ad1a"

    livecheck do
      skip "pinned commit"
    end
  end

  def install
    # Build the persistent PTY helper from source instead of embedding the prebuilt npm binary
    (buildpath/"ghostty").install resource("ghostty")
    ENV["GHOSTTY_SOURCE_DIR"] = buildpath/"ghostty"
    cd "ghostty" do
      system "zig", "fetch", resource("aro").cached_download
    end
    system "cargo", "install", *std_cargo_args(root: buildpath/"opencode-pty", path: "packages/process-daemon")
    ENV["OPENCODE_PTY_BIN"] = buildpath/"opencode-pty/bin/opencode-pty"

    ENV["OPENCODE_VERSION"] = version.to_s
    ENV["OPENCODE_CHANNEL"] = "latest"

    # Fix server errors when building with Bun 1.4.2 by disabling splitting
    # https://github.com/anomalyco/opencode/issues/48645
    # https://github.com/NixOS/nixpkgs/issues/563241
    inreplace "packages/cli/script/build.ts", "splitting: true,", "splitting: false,"

    system "bun", "install", "--frozen-lockfile"

    cd "packages/cli" do
      system "bun", "--bun", "./script/build.ts", "--single", "--skip-install"
      bin.install Pathname.pwd.glob("dist/cli-*/bin/opencode").first
    end

    generate_completions_from_executable(bin/"opencode", shell_parameter_format: "--completions=")
  end

  test do
    ENV["OPENCODE_DISABLE_AUTOUPDATE"] = "1"
    ENV["OPENCODE_DISABLE_MODELS_FETCH"] = "1"

    assert_match version.to_s, shell_output("#{bin}/opencode --version")

    (testpath/"opencode.json").write <<~JSON
      { "agent": { "brewtest": { "description": "Homebrew test agent", "prompt": "hi" } } }
    JSON
    # The standalone server listens on localhost, so network access can't be denied here
    entries = JSON.parse(shell_output("#{bin}/opencode api --standalone config.get"))
    project = entries.find { |entry| entry["path"] == (testpath/"opencode.json").realpath.to_s }
    assert_equal "hi", project.dig("info", "agents", "brewtest", "system")
  end
end
