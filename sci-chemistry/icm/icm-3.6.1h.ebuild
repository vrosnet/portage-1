# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/icm/icm-3.6.1h.ebuild,v 1.2 2010/03/09 11:36:56 abcd Exp $

inherit rpm eutils versionator

MY_PV=$(replace_version_separator 2 '-' )
MY_P="$PN-${MY_PV}"
DESCRIPTION="MolSoft LCC ICM Pro"
SRC_URI="${MY_P}.i386.rpm"
HOMEPAGE="http://www.molsoft.com/icm_pro.html"
LICENSE="MolSoft"

SLOT=0

DEPEND="!sci-chemistry/icm-browser
		amd64? (
				app-emulation/emul-linux-x86-compat
				app-emulation/emul-linux-x86-xlibs
				)
		x86? (
				virtual/libstdc++
				)"
RDEPEND="$DEPEND"

KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="fetch"

S="${WORKDIR}/usr/${MY_P}"

pkg_nofetch() {
	einfo "Please download ${SRC_URI} from "
	einfo "${HOMEPAGE}"
	einfo "and move it to ${DISTDIR}"
}

src_unpack() {
	rpm_src_unpack
	cd "${S}" || die
}

src_install () {
	instdir=/opt/icm
	dodir "${instdir}"
	dodir "${instdir}/licenses"
	cp -pPR * "${D}/${instdir}"
	doenvd "${FILESDIR}/90icm" || die
	exeinto ${instdir}
	doexe "${S}/icm" || die
	doexe "${S}/lmhostid" || die
	doexe "${S}/txdoc" || die
	dosym "${instdir}/icm"  /opt/bin/icm || die
	dosym "${instdir}/txdoc"  /opt/bin/txdoc || die
	dosym "${instdir}/lmhostid"  /opt/bin/lmhostid || die
	# make desktop entry
	doicon "${FILESDIR}/${PN}.png"
	make_desktop_entry "icm -g" "ICM Pro" ${PN} Chemistry
}

pkg_postinst () {
	einfo
	einfo "Documentation can be found in ${instdir}/man/"
	einfo
	einfo "You will need to place your license in ${instdir}/licenses/"
	einfo

}
