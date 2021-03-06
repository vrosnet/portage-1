# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gnutls/gnutls-3.0.20.ebuild,v 1.4 2012/08/02 20:08:08 radhermit Exp $

EAPI=4

inherit autotools libtool eutils

DESCRIPTION="A TLS 1.2 and SSL 3.0 implementation for the GNU project"
HOMEPAGE="http://www.gnutls.org/"

if [[ "${PV}" == *pre* ]]; then
	SRC_URI="http://daily.josefsson.org/${P%.*}/${P%.*}-${PV#*pre}.tar.gz"
else
	MINOR_VERSION="${PV#*.}"
	MINOR_VERSION="${MINOR_VERSION%%.*}"
	if [[ $((MINOR_VERSION % 2)) == 0 ]]; then
		#SRC_URI="ftp://ftp.gnu.org/pub/gnu/${PN}/${P}.tar.bz2"
		SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"
	else
		SRC_URI="ftp://alpha.gnu.org/gnu/${PN}/${P}.tar.xz"
	fi
	unset MINOR_VERSION
fi

# LGPL-3 for libgnutls library and GPL-3 for libgnutls-extra library.
LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="+cxx doc examples guile nls pkcs11 static-libs test zlib"

RDEPEND=">=dev-libs/libtasn1-0.3.4
	>=dev-libs/nettle-2.4[gmp]
	sys-devel/autogen
	guile? ( >=dev-scheme/guile-1.8[networking] )
	nls? ( virtual/libintl )
	pkcs11? ( >=app-crypt/p11-kit-0.11 )
	zlib? ( >=sys-libs/zlib-1.2.3.1 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/libtool
	doc? ( dev-util/gtk-doc )
	nls? ( sys-devel/gettext )
	test? ( app-misc/datefudge )"

S=${WORKDIR}/${P%_pre*}

DOCS=( AUTHORS ChangeLog NEWS README THANKS doc/TODO )

src_prepare() {
	local dir file

	# tests/suite directory is not distributed.
	sed -i \
		-e ':AC_CONFIG_FILES(\[tests/suite/Makefile\]):d' \
		-e '/^AM_INIT_AUTOMAKE/s/-Werror//' \
		configure.ac || die

	sed -i \
		-e 's/imagesdir = $(infodir)/imagesdir = $(htmldir)/' \
		doc/Makefile.am || die

	for dir in m4 gl/m4; do
		rm -f "${dir}/lt"* "${dir}/libtool.m4"
	done
	find . -name ltmain.sh -exec rm {} \;

	# use system libopts
	sed -i -e "/^enable_local_libopts/s/yes/no/" configure.ac || die

	# force regeneration of autogen-ed files
	for file in $(grep -l AutoGen-ed src/*.c) ; do
		rm src/$(basename ${file} .c).{c,h} || die
	done

	# support user patches
	epatch_user

	epatch "${FILESDIR}"/${P}-parallelmake.patch

	eautoreconf

	# Use sane .so versioning on FreeBSD.
	elibtoolize
}

src_configure() {
	econf \
		--htmldir="${EPREFIX}/usr/share/doc/${PF}/html" \
		--disable-silent-rules \
		--disable-valgrind-tests \
		$(use_enable cxx) \
		$(use_enable doc gtk-doc) \
		$(use_enable doc gtk-doc-pdf) \
		$(use_enable guile) \
		$(use_enable nls) \
		$(use_enable static-libs static) \
		$(use_with pkcs11 p11-kit) \
		$(use_with zlib) \
		${myconf}
}

src_test() {
	# let it build in parallel
	emake check
}

src_install() {
	default

	find "${ED}" -name '*.la' -exec rm -f {} +

	if use doc; then
		dodoc doc/gnutls.{pdf,ps}
		dohtml doc/gnutls.html
	fi

	if use examples; then
		docinto examples
		dodoc doc/examples/*.c
	fi
}
