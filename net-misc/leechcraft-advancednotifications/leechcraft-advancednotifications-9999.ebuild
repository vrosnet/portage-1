# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-advancednotifications/leechcraft-advancednotifications-9999.ebuild,v 1.4 2012/07/15 16:02:44 kensington Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Flexible and customizable notifications framework for LeechCraft."

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}
	x11-libs/qt-declarative:4"
RDEPEND="${DEPEND}"

pkg_postinst() {
	einfo "Advanced Notifications supports playing sounds on various"
	einfo "events. Install some media playback plugin to enjoy this"
	einfo "feature (media-video/leechcraft-lmp will do, for example)."
}
