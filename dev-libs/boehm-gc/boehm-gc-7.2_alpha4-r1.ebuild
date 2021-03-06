# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/boehm-gc/boehm-gc-7.2_alpha4-r1.ebuild,v 1.3 2012/05/29 19:17:13 jlec Exp $

EAPI=4

inherit autotools-utils

MY_P="gc-${PV/_/}"

DESCRIPTION="The Boehm-Demers-Weiser conservative garbage collector"
HOMEPAGE="http://www.hpl.hp.com/personal/Hans_Boehm/gc/"
SRC_URI="http://www.hpl.hp.com/personal/Hans_Boehm/gc/gc_source/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="cxx static-libs threads"

DEPEND="dev-libs/libatomic_ops"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

DOCS=( README.QUICK doc/README{,.environment,.linux,.macros} doc/barrett_diagram )

src_prepare() {
	sed '/Cflags/s:$:/gc:g' -i bdw-gc.pc.in || die
	rm -rvf libatomic_ops || die
	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		--with-libatomic-ops=yes
		$(use_enable cxx cplusplus)
		$(use threads || echo --disable-threads)
		)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install

	rm -rf "${ED}"/usr/share/gc || die

	# dist_noinst_HEADERS
	insinto /usr/include/gc
	doins include/{cord.h,ec.h,javaxfc.h}
	insinto /usr/include/gc/private
	doins include/private/*.h

	dohtml doc/*.html
	newman doc/gc.man GC_malloc.1
}
