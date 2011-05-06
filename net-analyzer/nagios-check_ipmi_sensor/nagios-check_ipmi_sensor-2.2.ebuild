# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagios-check_ipmi_sensor/nagios-check_ipmi_sensor-2.2.ebuild,v 1.2 2011/05/06 08:11:34 tomka Exp $

EAPI=3

inherit multilib

MY_P="${PN#nagios-}_v${PV}"

DESCRIPTION="IPMI Sensor Monitoring Plugin for Nagios/Icinga"
HOMEPAGE="http://www.thomas-krenn.com/en/oss/ipmi-plugin/"
SRC_URI="http://www.thomas-krenn.com/en/oss/ipmi-plugin/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="2"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="!net-analyzer/nagios-check_ipmi_sensor:1
	sys-apps/gawk
	sys-libs/freeipmi"

S="${WORKDIR}/${MY_P}"

src_install() {
	exeinto /usr/$(get_libdir)/nagios/plugins
	doexe check_ipmi_sensor || die

	dodoc changelog.txt
}
