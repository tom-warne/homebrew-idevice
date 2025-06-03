class Libfwkeyfetch < Formula
  desc "General stuff for tihmstar's projects"
  homepage "https://github.com/tihmstar/libfwkeyfetch"
  url "https://github.com/tihmstar/libfwkeyfetch.git",
    revision: "7d9858ac5740889b6ff6c23137768256eedae6c9"
  version "5"
  license "LGPL-2.1-or-later"
  head "https://github.com/tihmstar/libfwkeyfetch.git", branch: "master"

  livecheck do
    url :homepage
    strategy :page_match
    regex(/(\d+) Commits/im)
  end

  bottle do
    root_url "https://github.com/tom-warne/homebrew-idevice/releases/download/libgeneral"
    sha256 cellar: :any, sequoia:      "232c418402758ffb7ded54849d8a5e3362bc70295f752a0ce5cab95507bc340a"
    sha256 cellar: :any, arm64_sonoma: "8fb71f18058442679e0623e40ec9bae2ea21da7ef86624d0e18228ca0116b6b8"
    sha256 cellar: :any, ventura:      "f598b2159ba5aa15c4023717d9cf0e5cf43c9dcfc47e4f7ea8c3ff38af63b205"
  end

  keg_only "its an utility library for tihmstar's projects and shouldnt be used by anything else"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def fix_tihmstar
    inreplace %w[configure.ac],
      "e",
      "echo #{version.to_s.gsub(/[^\d]/, "")}",
      audit_result: false
  end

  def install
      # fix_tihmstar

    system "./autogen.sh", "--disable-dependency-tracking", "--prefix=#{self.prefix}"
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end
end
