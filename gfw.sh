#!/bin/bash

echo 'walk and see';

cd publish;
# download it for me
wget https://github.com/jgm/pandoc/releases/download/1.17.0.1/pandoc-1.17.0.1-1-amd64.deb;
wget https://github.com/jgm/pandoc/releases/download/1.17.0.1/pandoc-1.17.0.1-windows.msi;
wget https://github.com/jgm/pandoc/releases/download/1.17.0.1/pandoc-1.17.0.1-osx.pkg;
cd ..;
