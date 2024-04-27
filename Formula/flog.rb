class Flog < Formula
  desc "Command-line tool for sending log messages to Apple's unified logging system"
  homepage "https://github.com/marcransome/flog"
  url "https://github.com/marcransome/flog/archive/refs/tags/v1.6.0.tar.gz"
  sha256 "81e01813b6f7f4e96d274733a71ccdbc905bd9d05dfcb713e3f6b55aa3892fe5"
  license "MIT"

  depends_on :macos
  depends_on "popt"

  resource "binary" do
    on_arm do
      url "https://github.com/marcransome/flog/releases/download/v1.6.0/flog-v1.6.0-darwin-arm64.tar.xz"
      sha256 "395086f5e0305e307161788610de7c0afd3c246e2018b89ccf4ae2bc7d63f002"
    end

    on_intel do
      url "https://github.com/marcransome/flog/releases/download/v1.6.0/flog-v1.6.0-darwin-x86_64.tar.xz"
      sha256 "216312017032d77c161049a3ec4f41a4e2c636333e59bce4ec976e2d8e054afc"
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
    assert_equal "flog v1.6.0", shell_output("#{bin}/flog --version").chomp
    system bin/"flog",
        "--subsystem", "uk.co.fidgetbox.flog",
        "--category", "internal",
        "--level", "debug",
        "--append", testpath/"output.txt",
        "Flog v1.6.0 test message"
    assert_predicate testpath/"output.txt", :exist?
    assert_match "Flog v1.6.0 test message", shell_output("cat #{testpath}/output.txt").chomp
  end
end
