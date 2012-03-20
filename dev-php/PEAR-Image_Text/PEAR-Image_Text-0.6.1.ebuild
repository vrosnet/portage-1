# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Image_Text/PEAR-Image_Text-0.6.1.ebuild,v 1.2 2012/03/20 08:25:48 ago Exp $

EAPI=4

inherit php-pear-r1

DESCRIPTION="Advanced text manipulations in images."
LICENSE="PHP-3"
SLOT="0"

KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/php[gd]"
