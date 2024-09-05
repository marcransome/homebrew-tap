class Flog < Formula
  desc "Command-line tool for sending log messages to Apple's unified logging system"
  homepage "https://github.com/marcransome/flog"
  url "https://github.com/marcransome/flog/archive/refs/tags/v1.6.1.tar.gz"
  sha256 "b3c599772a556520e48dbe85bc51dfe0ea9ee2558347f0691c88b58a0f467682"
  license "MIT"

  depends_on :macos
  depends_on "popt"

  resource "binary" do
    on_arm do
      url "https://github.com/marcransome/flog/releases/download/v1.6.1/flog-v1.6.1-darwin-arm64.tar.xz"
      sha256 "f076333d7dbbc0b7e1f83820f6e27e7a6307609d068ad1019f674d578d0bba00"
    end

    on_intel do
      url "https://github.com/marcransome/flog/releases/download/v1.6.1/flog-v1.6.1-darwin-x86_64.tar.xz"
      sha256 "895e2394e198d98c968b377c409442a3cee9c1d9cbbed65312175b26eb330182"
    end
  end

  def install
    resource("binary").stage do
      bin.install "bin/flog"
      man1.install "usr/share/man/man1/flog.1"
    end
  end

  test do
    assert_predicate bin/"flog", :exist?
    assert_predicate bin/"flog", :executable?
    assert_equal "flog v1.6.1", shell_output("#{bin}/flog --version").chomp
    system bin/"flog",
        "--subsystem", "uk.co.fidgetbox.flog",
        "--category", "internal",
        "--level", "debug",
        "--append", testpath/"output.txt",
        "Flog v1.6.1 test message"
    assert_predicate testpath/"output.txt", :exist?
    assert_match "Flog v1.6.1 test message", shell_output("cat #{testpath}/output.txt").chomp
  end
end
