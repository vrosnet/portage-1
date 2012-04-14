# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/avr-libc/avr-libc-1.8.0.ebuild,v 1.3 2012/04/13 18:03:10 ulm Exp $

EAPI="4"

CHOST="avr"
CTARGET="avr"

inherit flag-o-matic

DESCRIPTION="C library for Atmel AVR microcontrollers"
HOMEPAGE="http://www.nongnu.org/avr-libc/"
SRC_URI="http://savannah.nongnu.org/download/avr-libc/${P}.tar.bz2
	http://savannah.nongnu.org/download/avr-libc/${PN}-manpages-${PV}.tar.bz2
	doc? ( http://savannah.nongnu.org/download/avr-libc/${PN}-user-manual-${PV}.tar.bz2 )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="doc crosscompile_opts_headers-only"

DEPEND=">=sys-devel/crossdev-0.9.1"
[[ ${CATEGORY/cross-} != ${CATEGORY} ]] \
	&& RDEPEND="!dev-embedded/avr-libc" \
	|| RDEPEND=""

DOCS="AUTHORS ChangeLog* NEWS README"

pkg_setup() {
	# check for avr-gcc, bug #134738
	ebegin "Checking for avr-gcc"
	if type -p avr-gcc > /dev/null ; then
		eend 0
	else
		eend 1

		eerror
		eerror "Failed to locate 'avr-gcc' in \$PATH. You can install an AVR toolchain using:"
		eerror "  $ crossdev -t avr"
		eerror
		die "AVR toolchain not found"
	fi
}

src_prepare() {
	# work around broken gcc versions PR45261
	local mcu
	for mcu in $(sed -r -n '/CHECK_AVR_DEVICE/{s:.*[(](.*)[)]:\1:;p}' configure.ac) ; do
		if avr-gcc -E - -mmcu=${mcu} <<<"" |& grep -q 'unknown MCU' ; then
			sed -i "/HAS_${mcu}=yes/s:yes:no:" configure
		fi
	done

	# Install docs in correct directory
	sed -i -e "/DOC_INST_DIR/s:\$(VERSION):${PVR}:" configure || die

	strip-flags
	strip-unsupported-flags
}

src_install() {
	default

	# man pages can not go into standard locations
	# as they would then overwrite libc man pages
	insinto /usr/share/doc/${PF}/man/man3
	doins "${WORKDIR}"/man/man3/*
	prepman /usr/share/doc/${PF}

	use doc	&& dohtml "${WORKDIR}"/${PN}-user-manual-${PV}/*
}
