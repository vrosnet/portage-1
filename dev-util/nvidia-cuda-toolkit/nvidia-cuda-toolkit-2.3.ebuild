# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/nvidia-cuda-toolkit/nvidia-cuda-toolkit-2.3.ebuild,v 1.5 2010/09/23 20:29:55 flameeyes Exp $

EAPI=2

inherit eutils multilib

DESCRIPTION="NVIDIA CUDA Toolkit"
HOMEPAGE="http://developer.nvidia.com/cuda"

CUDA_V=${PV//./_}

BASE_URI="http://developer.download.nvidia.com/compute/cuda/${CUDA_V}/toolkit"
SRC_URI="amd64? ( ${BASE_URI}/cudatoolkit_${PV}_linux_64_rhel5.3.run )
	x86? ( ${BASE_URI}/cudatoolkit_${PV}_linux_32_rhel5.3.run )"

LICENSE="NVIDIA"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debugger doc profiler"

DEPEND="!dev-util/nvidia-cuda-profiler"
RDEPEND="${DEPEND}
	>=sys-devel/gcc-4.0
	profiler? ( x86? (
		x11-libs/qt-gui
		x11-libs/qt-core
		x11-libs/qt-assistant
		x11-libs/qt-sql[sqlite] )
	)
	debugger? ( >=sys-libs/libtermcap-compat-2.0.8-r2 )"

S="${WORKDIR}"

src_unpack() {
	for f in ${A} ; do
		if [ "${f//*.run/}" == "" ]; then
			unpack_makeself ${f}
		fi
	done
}

src_install() {
	local DEST=/opt/cuda

	into ${DEST}
	dobin bin/*
	dolib $(get_libdir)/*

	if ! use debugger; then
		rm -f "${D}/${DEST}/bin/cuda-gdb"
	fi

	chmod a-x "${D}/${DEST}/bin/nvcc.profile"

	# doman does not respect DESTTREE
	insinto ${DEST}/man/man1
	doins man/man1/*
	insinto ${DEST}/man/man3
	doins man/man3/*
	prepman ${DEST}

	insinto ${DEST}/include
	doins include/*.h
	insinto ${DEST}/include/crt
	doins include/crt/*.h

	insinto ${DEST}/src
	doins src/*

	if use doc ; then
		insinto ${DEST}/doc
		doins -r doc/*
	fi

	cat > "${T}/env" << EOF
PATH=${DEST}/bin
ROOTPATH=${DEST}/bin
LDPATH=${DEST}/$(get_libdir)
MANPATH=${DEST}/man
EOF
	newenvd "${T}/env" 99cuda

	if use profiler; then
		into ${DEST}/cudaprof
		dobin cudaprof/bin/cudaprof

		cat > "${T}/env" << EOF
PATH=${DEST}/cudaprof/bin
ROOTPATH=${DEST}/cudaprof/bin
EOF
		if use x86 ; then
			dosym /usr/bin/assistant ${DEST}/cudaprof/bin
		else
			dobin cudaprof/bin/assistant
			insinto ${DEST}/cudaprof/bin
			doins cudaprof/bin/*.so*
			insinto ${DEST}/cudaprof/bin/sqldrivers
			doins cudaprof/bin/sqldrivers/*

			cat >> "${T}/env" << EOF
LDPATH=${DEST}/cudaprof/bin
EOF
		fi

		newenvd "${T}/env" 99cudaprof

		if use doc; then
			insinto ${DEST}/cudaprof
			doins cudaprof/CUDA_Visual_Profiler_Release_Notes.txt
			insinto ${DEST}/cudaprof/doc
			doins cudaprof/doc/*
			insinto ${DEST}/cudaprof/projects
			doins cudaprof/projects/*
		fi
	fi

	export CONF_LIBDIR_OVERRIDE="lib"
	# HACK: temporary workaround until CONF_LIBDIR_OVERRIDE is respected.
	export LIBDIR_amd64="lib"

	into ${DEST}/open64
	dobin open64/bin/*
	libopts -m0755
	dolib open64/lib/*
}

pkg_postinst() {
	elog "If you want to natively run the code generated by this version of the"
	elog "CUDA toolkit, you will need >=x11-drivers/nvidia-drivers-190.38."
	elog ""
	elog "Run '. /etc/profile' before using the CUDA toolkit. "
}
