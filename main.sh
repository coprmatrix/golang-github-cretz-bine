outdir="${outdir:-.}"

cp *.spec ${outdir:-.} ||:

obsinfo="$(cat tor-static.obsinfo)"
obsinfo="${obsinfo//: /=}"
eval "$obsinfo"

prefix(){
echo '%define master ' ${version}
cat << 'EOF'
BuildRequires: gcc
BuildRequires: gcc-c++
BuildRequires: make
BuildRequires: automake
BuildRequires: autoconf
BuildRequires: bash
BuildRequires: libtool
BuildRequires: gettext
BuildRequires: libcap-static
BuildRequires: glibc-static
BuildRequires: libzstd-static
BuildRequires: asciidoc
BuildRequires: libcap-devel
BuildRequires: libzstd-devel
BuildRequires: glibc-devel
BuildRequires: po4a
BuildRequires: golang
BuildRequires: perl
BuildRequires: perl(FindBin)
BuildRequires: gettext-devel
Source1: tor-static-%{master}.tar.gz
%global prebuild %{expand:
%{_rpmconfigdir}/rpmuncompress -x %{SOURCE1}
ln $PWD/tor-static-%{master} $PWD/../tor-static -sfvT
pushd $PWD/tor-static-%{master}
env -i HOME=$HOME PATH=$PATH go run build.go --verbose build-all
popd
}
EOF
}

file="$(prefix; cat "${outdir}"/*.spec)"
echo "$file" > "${outdir}"/*.spec



