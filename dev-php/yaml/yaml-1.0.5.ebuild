# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/yaml/yaml-1.0.5.ebuild,v 1.4 2011/04/16 12:51:49 olemarkus Exp $

EAPI=3

PHP_PEAR_CHANNEL="${FILESDIR}/channel.xml"
PHP_PEAR_PN="YAML"

inherit php-pear-lib-r1

DESCRIPTION="The Symfony YAML Component."
HOMEPAGE="http://symfony-project.com/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
