class Flog < Formula
  desc "A command-line tool for sending log messages to Apple's unified logging system."
  homepage "https://github.com/marcransome/flog"
  url "https://github.com/marcransome/flog/archive/1.0.0.tar.gz"
  sha256 "ba168e3fa1a57ebfa126bc368f6141841d5d3b19e18ad95e3ccd2741c556ea2d"
  license "MIT"

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build", "--prefix", "#{prefix}"
  end

  test do
    system "#{bin}/flog --version"
  end
end
