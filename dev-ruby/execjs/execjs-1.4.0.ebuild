# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/execjs/execjs-1.4.0.ebuild,v 1.1 2012/06/29 05:05:04 graaff Exp $

EAPI=4
USE_RUBY="ruby18 ruby19 ree18"

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="README.md"

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

GITHUB_USER="sstephenson"
GITHUB_PROJECT="${PN}"
RUBY_S="${GITHUB_USER}-${GITHUB_PROJECT}-*"

inherit ruby-fakegem

DESCRIPTION="ExecJS lets you run JavaScript code from Ruby"
HOMEPAGE="https://github.com/sstephenson/execjs"
SRC_URI="https://github.com/${GITHUB_USER}/${GITHUB_PROJECT}/tarball/v${PV} -> ${P}-git.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x64-macos"

IUSE="test"

ruby_add_rdepend ">=dev-ruby/multi_json-1.0"

# execjs supports various javascript runtimes. They are listed in order
# as per the documentation. For now only include the ones already in the
# tree.

# therubyracer, therubyrhino, node.js, spidermonkey (deprecated)

# spidermonkey doesn't pass the test suite:
# https://github.com/sstephenson/execjs/issues/62

RDEPEND="${RDEPEND} || ( net-libs/nodejs )"
