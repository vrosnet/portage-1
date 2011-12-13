# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/redmine/redmine-1.2.3.ebuild,v 1.1 2011/12/12 16:39:48 matsuu Exp $

EAPI="3"
USE_RUBY="ruby18"
inherit eutils depend.apache ruby-ng

DESCRIPTION="Redmine is a flexible project management web application written using Ruby on Rails framework"
HOMEPAGE="http://www.redmine.org/"
SRC_URI="mirror://rubyforge/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
SLOT="0"
#IUSE="bazaar cvs darcs fastcgi git imagemagick mercurial mysql openid passenger postgres sqlite3 subversion"
IUSE="fastcgi imagemagick openid passenger"

RDEPEND="$(ruby_implementation_depend ruby18 '>=' -1.8.6)[ssl]"

ruby_add_rdepend "virtual/ruby-ssl
	virtual/rubygems
	=dev-ruby/coderay-0.9*
	>=dev-ruby/ruby-net-ldap-0.0.4
	~dev-ruby/i18n-0.4.2
	~dev-ruby/rack-1.1.0
	dev-ruby/rake
	dev-ruby/rails:2.3
	dev-ruby/activerecord:2.3
	fastcgi? ( dev-ruby/ruby-fcgi )
	imagemagick? ( dev-ruby/rmagick )
	openid? ( dev-ruby/ruby-openid )
	passenger? ( www-apache/passenger )"

#RDEPEND="${RDEPEND}
#	bazaar ( dev-vcs/bazaar )
#	cvs? ( >=dev-vcs/cvs-1.12 )
#	darcs? ( dev-vcs/darcs )
#	git? ( dev-vcs/git )
#	mercurial? ( dev-vcs/mercurial )
#	subversion? ( >=dev-vcs/subversion-1.3 )"

REDMINE_DIR="/var/lib/${PN}"

pkg_setup() {
	enewgroup redmine
	# home directory is required for SCM.
	enewuser redmine -1 -1 "${REDMINE_DIR}" redmine
}

all_ruby_prepare() {
	rm -r log files/delete.me || die
	rm -r vendor/gems/coderay-0.9.7 || die
	rm -r vendor/plugins/ruby-net-ldap-0.0.4 || die
	rm -fr vendor/rails || die
	echo "CONFIG_PROTECT=\"${EPREFIX}${REDMINE_DIR}/config\"" > "${T}/50${PN}"
	echo "CONFIG_PROTECT_MASK=\"${EPREFIX}${REDMINE_DIR}/config/locales ${EPREFIX}${REDMINE_DIR}/config/settings.yml\"" >> "${T}/50${PN}"
	sed -i -e "/RAILS_GEM_VERSION/s/'.*'/'$(best_version dev-ruby/rails:2.3|cut -d- -f3)'/" config/environment.rb || die
}

all_ruby_install() {
	dodoc doc/{CHANGELOG,INSTALL,README_FOR_APP,RUNNING_TESTS,UPGRADING} || die
	rm -fr doc || die

	keepdir /var/log/${PN} || die
	dosym /var/log/${PN}/ "${REDMINE_DIR}/log" || die

	insinto "${REDMINE_DIR}"
	doins -r . || die
	keepdir "${REDMINE_DIR}/files" || die
	keepdir "${REDMINE_DIR}/public/plugin_assets" || die

	fowners -R redmine:redmine \
		"${REDMINE_DIR}/config/environment.rb" \
		"${REDMINE_DIR}/files" \
		"${REDMINE_DIR}/public/plugin_assets" \
		"${REDMINE_DIR}/tmp" \
		/var/log/${PN} || die
	# for SCM
	fowners redmine:redmine "${REDMINE_DIR}" || die

	if use passenger ; then
		has_apache
		insinto "${APACHE_VHOSTS_CONFDIR}"
		doins "${FILESDIR}/10_redmine_vhost.conf" || die
	else
		newconfd "${FILESDIR}/${PN}.confd" ${PN} || die
		newinitd "${FILESDIR}/${PN}.initd" ${PN} || die
		keepdir /var/run/${PN} || die
		fowners -R redmine:redmine /var/run/${PN} || die
		dosym /var/run/${PN}/ "${REDMINE_DIR}/tmp/pids" || die
	fi
	doenvd "${T}/50${PN}" || die
}

pkg_postinst() {
	einfo
	if [ -e "${EPREFIX}${REDMINE_DIR}/config/initializers/session_store.rb" ] ; then
		elog "Execute the following command to upgrade environment:"
		elog
		elog "# emerge --config \"=${CATEGORY}/${PF}\""
		elog
		elog "For upgrade instructions take a look at:"
		elog "http://www.redmine.org/wiki/redmine/RedmineUpgrade"
	else
		elog "Execute the following command to initlize environment:"
		elog
		elog "# cd ${EPREFIX}${REDMINE_DIR}"
		elog "# cp config/database.yml.example config/database.yml"
		elog "# \${EDITOR} config/database.yml"
		elog "# emerge --config \"=${CATEGORY}/${PF}\""
		elog
		elog "Installation notes are at official site"
		elog "http://www.redmine.org/wiki/redmine/RedmineInstall"
	fi
	einfo
}

pkg_config() {
	if [ ! -e "${EPREFIX}${REDMINE_DIR}/config/database.yml" ] ; then
		eerror "Copy ${EPREFIX}${REDMINE_DIR}/config/database.yml.example to ${EPREFIX}${REDMINE_DIR}/config/database.yml and edit this file in order to configure your database settings for \"production\" environment."
		die
	fi

	local RAILS_ENV=${RAILS_ENV:-production}
	local RUBY=${RUBY:-ruby18}

	cd "${EPREFIX}${REDMINE_DIR}"
	if [ -e "${EPREFIX}${REDMINE_DIR}/config/initializers/session_store.rb" ] ; then
		einfo
		einfo "Upgrade database."
		einfo

		einfo "Migrate database."
		RAILS_ENV="${RAILS_ENV}" ${RUBY} -S rake db:migrate || die
		einfo "Upgrade the plugin migrations."
		RAILS_ENV="${RAILS_ENV}" ${RUBY} -S rake db:migrate:upgrade_plugin_migrations # || die
		RAILS_ENV="${RAILS_ENV}" ${RUBY} -S rake db:migrate_plugins || die
		einfo "Clear the cache and the existing sessions."
		${RUBY} -S rake tmp:cache:clear || die
		${RUBY} -S rake tmp:sessions:clear || die
	else
		einfo
		einfo "Initialize database."
		einfo

		einfo "Generate a session store secret."
		${RUBY} -S rake generate_session_store || die
		einfo "Create the database structure."
		RAILS_ENV="${RAILS_ENV}" ${RUBY} -S rake db:migrate || die
		einfo "Insert default configuration data in database."
		RAILS_ENV="${RAILS_ENV}" ${RUBY} -S rake redmine:load_default_data || die
	fi

	if [ ! -e "${EPREFIX}${REDMINE_DIR}/config/email.yml" ] ; then
		ewarn
		ewarn "Copy ${EPREFIX}${REDMINE_DIR}/config/email.yml.example to ${EPREFIX}${REDMINE_DIR}/config/email.yml and edit this file to adjust your SMTP settings."
		ewarn
	fi
}
