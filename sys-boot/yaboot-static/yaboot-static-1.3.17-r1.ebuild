# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/yaboot-static/yaboot-static-1.3.17-r1.ebuild,v 1.1 2012/05/12 03:20:41 josejx Exp $

EAPI=2

inherit eutils

DESCRIPTION="Static yaboot ppc boot loader for machines with open firmware"
### Generated by using quickpkg on a ppc32 machine, compiled with -O2 -pipe

HOMEPAGE="http://penguinppc.org/projects/yaboot/"
SRC_URI="mirror://gentoo/yaboot-static-${PV}.tbz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~ppc64"
IUSE="ibm"
DEPEND="!sys-boot/yaboot
		sys-apps/powerpc-utils"
RDEPEND="!ibm? ( sys-fs/hfsutils
				 sys-fs/hfsplusutils
				 sys-fs/mac-fdisk )"

src_prepare() {
	# Fix the devspec path on newer kernels
	epatch "${FILESDIR}/new-ofpath-devspec.patch"
}

src_install() {
	cp -pPR "${WORKDIR}"/* "${D}" || die "cp failed"
}
