## Building From Source

1) Clone the `cdrdao-pled` source tree from GitHub **recursively**:

    git clone --recursive https://github.com/alex-free/cdrdao-pled

2) Execute the build script (doesn't matter if you cd into the source directory to do so beforehand):

    cdrdao-pled/build

On Fedora and Debian, the below dependencies will be installed automatically by the build script:

*   [GNUmake](https://www.gnu.org/software/make/)
*   [GCC/G++](https://www.gnu.org/software/gcc)
*   [Bash](https://www.gnu.org/software/bash)
*   [Git](https://git-scm.com/)
*   [Libao](https://xiph.org/ao/)
*   [GNU Automake](https://www.gnu.org/software/automake/)
*   [GNU Autoconf](https://www.gnu.org/software/autoconf/)
*   [Zip](https://infozip.sourceforge.net/)

If so desired, you may then execute the build script with the `clean` argument to delete all built objects from the source tree.
