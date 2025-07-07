class Terrawiz < Formula
  desc "A blazing-fast CLI tool for discovering and analyzing Terraform modules"
  homepage "https://github.com/tronicum/terrawiz"
  url "https://registry.npmjs.org/terrawiz/-/terrawiz-0.2.0.tgz"
  sha256 "74a673fb06f2e4d02ac85a0c523657a20d3e6559dfbb025e04afef8434ced9ea"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    
    # Create a wrapper script that points to the correct location
    (bin/"terrawiz").write <<~EOS
      #!/bin/bash
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/lib/node_modules/terrawiz/dist/src/index.js" "$@"
    EOS
    
    # Make it executable
    chmod 0755, bin/"terrawiz"
  end

  test do
    system "#{bin}/terrawiz", "--version"
  end
end
