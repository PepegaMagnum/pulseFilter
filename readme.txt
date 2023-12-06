Kompilacja modułu oraz testbench została przetestowana dla następujących narzędzi na dystrybucji systemu operacyjnego Linux Ubuntu:
- Vivado 2023.2 (symulator wbudowany w Vivado)
- Quartus Prime Lite Edition (Modelsim 20.1.1.720).

Oprócz kompilacji za pomocy automatycznych narzędzi w obu środowiskach IDE to moduł też można skompilować z wiersza komend. 
W folderze src znajdują się pliki potrzebne do kompilacji modułu, natomiast w folderze sim znajdują się pliki kompilacyjne.

Nie udało się napisać samoweryfikującego testbencha. Oprócz testbencha VHDL w folderze sim znajduje się plik Makefile dla CocoTB.
Jednak cocoTB nie jest kompatybilne z ogólnodostępną wersją symulatora Modelsim oraz symulatora GHDL który dostępny jest w repozytorium Ubuntu.
