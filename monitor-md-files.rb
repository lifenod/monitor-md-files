#!/usr/bin/env ruby


require 'filewatcher'


HOME_PATH = "/Users/mwum"
HTML_PATH = "#{HOME_PATH}/Bin/pages.15154.org/xu"
CODE_HELPER_PATH = "#{HOME_PATH}/Code-helper"

infile_outfile = {
  "#{CODE_HELPER_PATH}/test/project1/note.md" => "#{HTML_PATH}/test-project1-note.md.html",
  "#{CODE_HELPER_PATH}/test/project2/note.md" => "#{HTML_PATH}/test-project2-note.md.html"
}

FileWatcher.new(infile_outfile.map { |k| k[0] }).watch do |infile|
  outfile = infile_outfile[infile]

  cmd =
    "pandoc #{infile} "   \
    "-f markdown "        \
    "-t html "            \
    "-o #{outfile} "      \
    "--toc "              \
    "-c ../main.css "

  if File.exist?(infile)
    Thread.new do
      system cmd
    end
  end
end
