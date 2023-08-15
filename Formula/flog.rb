class Flog < Formula
  desc "Command-line tool for sending log messages to Apple's unified logging system"
  homepage "https://github.com/marcransome/flog"
  url "https://github.com/marcransome/flog/archive/1.4.0.tar.gz"
  sha256 "7fba0b9ff68b6c283d30f53f0d221750a11d84e7cf744662aedf3973b1744677"
  license "MIT"
  revision 2

  depends_on "cmake" => :build
  depends_on :macos
  depends_on "popt"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build", "--prefix", prefix.to_s

    man1.install "man/flog.1"
  end

  test do
    assert_predicate bin/"flog", :exist?
    assert_predicate bin/"flog", :executable?
    assert_equal "flog #{version}", shell_output("#{bin}/flog --version").chomp
    system bin/"flog",
        "--subsystem", "uk.co.fidgetbox.flog",
        "--category", "internal",
        "--level", "debug",
        "--append", testpath/"output.txt",
        "Flog #{version} test message"
    assert_predicate testpath/"output.txt", :exist?
    assert_match "Flog #{version} test message", shell_output("cat #{testpath}/output.txt").chomp
  end
end
