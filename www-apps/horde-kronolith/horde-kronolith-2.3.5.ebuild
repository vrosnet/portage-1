# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/horde-kronolith/horde-kronolith-2.3.5.ebuild,v 1.5 2012/03/02 23:01:17 klausman Exp $

HORDE_PHP_FEATURES="-o mysql mysqli odbc postgres ldap"
HORDE_MAJ="-h3"
inherit horde

DESCRIPTION="Kronolith is the Horde calendar application"

KEYWORDS="alpha amd64 hppa ~ppc ~sparc x86"

DEPEND=""
RDEPEND=">=www-apps/horde-3"
