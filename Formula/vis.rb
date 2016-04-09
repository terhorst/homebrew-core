class Vis < Formula
  desc "Vim-like text editor"
  homepage "https://github.com/martanne/vis"
  # url "https://github.com/martanne/vis/archive/v0.2.tar.gz"
  # sha256 "3e5b81d760849c56ee378421e9ba0f653c641bf78e7594f71d85357be99a752d"

  head "https://github.com/martanne/vis.git", :revision => "d7c917ea63e037"

  depends_on "lua" => :recommended
  depends_on "lpeg" => :lua
  depends_on "libtermkey"

  def install
    ENV.append "CFLAGS", "-D VIS_OPEN='\"vis-editor-open\"'", "-D VIS_CLIPBOARD='\"vis-editor-clipboard\"'"
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
    ["", "-clipboard", "-open"].each do |base|
      mv bin/"vis#{base}", bin/"vis#{base}-editor"
    end
  end

  def caveats; <<-EOS.undent
    To avoid conflicting with the OS X system utility /usr/bin/vis, this
    text editor has been renamed to `vis-editor`.
  EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/vis-editor -v 2>&1", 1)
  end
end
