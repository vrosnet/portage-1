# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/cacti-spine/cacti-spine-0.8.7a_p4650.ebuild,v 1.3 2009/08/24 16:14:01 ramereth Exp $

WANT_AUTOCONF="latest"
inherit autotools subversion

if [[ "${PV}" =~ (_p)([0-9]+) ]] ; then
	inherit subversion
	SRC_URI=""
	MTSLPT_REV=${BASH_REMATCH[2]}
	ESVN_REPO_URI="svn://svn.cacti.net/var/svnroot/cacti/spine/branches/0.8.7/@${MTSLPT_REV}"
else
	MY_PV=${PV/_p/-}
	SRC_URI="http://www.cacti.net/downloads/spine/${PN}-${MY_PV}.tar.gz"
fi
DESCRIPTION="Spine is a fast poller for Cacti (formerly known as Cactid)"
HOMEPAGE="http://cacti.net/spine_info.php"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="net-analyzer/net-snmp
		virtual/mysql"
RDEPEND="${DEPEND}
		>net-analyzer/cacti-0.8.7"

src_unpack() {
	if [[ "${SRC_URI}" == "" ]] ; then
		subversion_src_unpack
	else
		unpack ${A}
	fi
	cd "${S}"
	sed -i -e 's/^bin_PROGRAMS/sbin_PROGRAMS/' Makefile.am
	rm configure # configure is not executable, autoconf recreates it...
	eautoreconf
}

src_install() {
	exeinto usr/sbin ; doexe "${S}"/spine
	insinto etc/ ; insopts -m0640 -o root ; newins "${S}"/spine.conf.dist spine.conf
	dodoc ChangeLog INSTALL README
}

pkg_postinst() {
	ewarn "NOTE: If you upgraded from cactid, do not forgive to setup spine"
	ewarn "instead of cactid through web interface."
	ewarn
	elog "Please see cacti's site for installation instructions."
	elog "Theres no need to change the crontab for this, just"
	elog "read the instructions on how to implement it"
	elog
	elog "http://cacti.net/spine_install.php"
	echo
	ewarn "/etc/spine.conf should be readable by webserver, thus after you"
	ewarn "decide on webserver/webserver group do not forget to change it's"
	ewarn "group with the following command:"
	ewarn
	ewarn " # chown root:wwwgroup /etc/spine.conf"
	echo
}
