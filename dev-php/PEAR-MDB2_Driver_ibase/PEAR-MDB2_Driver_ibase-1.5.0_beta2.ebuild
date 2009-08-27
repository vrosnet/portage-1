# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-MDB2_Driver_ibase/PEAR-MDB2_Driver_ibase-1.5.0_beta2.ebuild,v 1.1 2009/08/26 21:09:23 beandog Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Database Abstraction Layer, ibase driver"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-php/PEAR-MDB2-2.5.0_beta2"
RDEPEND="${DEPEND}"

pkg_setup() {
	require_php_with_any_use firebird interbase
}
