class Flog < Formula
  desc "Command-line tool for sending log messages to Apple's unified logging system"
  homepage "https://github.com/marcransome/flog"
  url "https://github.com/marcransome/flog/archive/refs/tags/v1.7.2.tar.gz"
  sha256 "d344bee2897708b81cb9b0018994368225cf7f1b874c92acb6aeb2390dbf617c"
  license "MIT"

  depends_on :macos
  depends_on "popt"

  resource "binary" do
    on_arm do
      url "https://github.com/marcransome/flog/releases/download/v1.7.2/flog-v1.7.2-darwin-arm64.tar.xz"
      sha256 "2a248ff17809ece0b2631d8e5052fbb9d69b3063d9f47d30cb82f801fcf39117"
    end

    on_intel do
      url "https://github.com/marcransome/flog/releases/download/v1.7.2/flog-v1.7.2-darwin-x86_64.tar.xz"
      sha256 "05b56ec7cb1e0b8372db3b0991b365c40775578e0276ed8f6084ccd00ede0e2a"
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
    assert_predicate prefix/"README.md", :exist?
    assert_predicate prefix/"LICENSE", :exist?
    assert_equal "flog v1.7.2", shell_output("#{bin}/flog --version").chomp
    system bin/"flog",
        "--subsystem", "uk.co.fidgetbox.flog",
        "--category", "internal",
        "--level", "debug",
        "--append", testpath/"output.txt",
        "Flog v1.7.2 test message"
    assert_predicate testpath/"output.txt", :exist?
    assert_match "Flog v1.7.2 test message", shell_output("cat #{testpath}/output.txt").chomp
  end
end
