# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/qlandkartegt/qlandkartegt-0.11.0.ebuild,v 1.2 2009/03/20 10:53:45 hanno Exp $

EAPI=1

inherit cmake-utils

DESCRIPTION="View and upload map files, track and waypoint data to your Garmin GPS."
HOMEPAGE="http://www.qlandkarte.org/"
SRC_URI="mirror://sourceforge/${PN}/QLandkarteGT.${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="|| (
	(
		x11-libs/qt-core:4
		x11-libs/qt-gui:4
		x11-libs/qt-opengl:4
	)
	=x11-libs/qt-4.3* )
	sci-libs/proj
	sci-libs/gdal"
RDEPEND="${DEPEND}"

S="${WORKDIR}/QLandkarteGT.2009.03.09"
