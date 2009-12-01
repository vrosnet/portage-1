# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdf/kdf-4.3.3.ebuild,v 1.4 2009/11/30 06:54:35 josejx Exp $

EAPI="2"

KMNAME="kdeutils"
inherit kde4-meta

DESCRIPTION="KDE free disk space utility"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ppc64 ~sparc ~x86"
IUSE="debug +handbook"

src_unpack() {
	if use handbook; then
		KMEXTRA="doc/kcontrol/blockdevices"
	fi

	kde4-meta_src_unpack
}
