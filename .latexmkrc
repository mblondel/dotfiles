# syntex option is used for forward search (sync text editor and pdf viewer position)
$pdflatex = 'pdflatex -synctex=1 %O %S';
$pdf_previewer = "open -a /Applications/Skim.app";
$pdf_mode = 1; # uses pdflatex
#$preview_continuous_mode = 1; # server mode by default
$pdf_update_method = 0; # viewer automatically updates
