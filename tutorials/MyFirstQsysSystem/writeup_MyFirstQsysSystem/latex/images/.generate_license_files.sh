#!/bin/sh

#
# Copyright (c) 2017 Intel Corporation
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.
#

#-------------------------------------------------------------------------------
# Change into the directory of this script
#-------------------------------------------------------------------------------
cd $(dirname "${0:?}")

INTEL_IMAGES="
./01-qsys-button.png
./01-qsys-open.png
./02-ocmem-search.png
./03-ocmem-parameters.png
./04-ocram-rename.png
./05-clk-ocram-connected.png
./05-clk-ocram-rst-tooltip.png
./06a-default_16b-ocram-connected.png
./06b-i-pio-connected.png
./06b-pio-parameters.png
./06c-sys-id-parameters.png
./06d-jtag-master-unconnected.png
./07a-mm-address-conflict-messages.png
./07b-assigned-addresses-default-slave.png
./07-jtag-master-avmm-connected.png
./08-generate.png
./09a-settings-files-qip.png
./09-qip-window.png
./12-pin-planner.png
./13-quartus-analysis-button.png
./14-start-compilation.png
./15-tcl-console.png
./qsys_block_diagram.png
"

TERASIC_IMAGES="
"

for NEXT_FILE in ${INTEL_IMAGES:?}
do
	FILE="${NEXT_FILE##*/}"

	[ -f "${FILE:?}" ] || {
		echo ""
		echo "ERROR: file not found"
		echo "'${FILE:?}'"
		echo ""
		exit 1
	}

	[ -f "LICENSE.${FILE:?}" ] && {
		echo ""
		echo "ERROR: file already exists"
		echo "'LICENSE.${FILE:?}'"
		echo ""
		exit 1
	}

	(
		echo "Copyright (c) 2017 Intel Corporation"
		echo "All rights reserved."
	) > "LICENSE.${FILE:?}"
done

for NEXT_FILE in ${TERASIC_IMAGES:?}
do
	FILE="${NEXT_FILE##*/}"

	[ -f "${FILE:?}" ] || {
		echo ""
		echo "ERROR: file not found"
		echo "'${FILE:?}'"
		echo ""
		exit 1
	}

	[ -f "LICENSE.${FILE:?}" ] && {
		echo ""
		echo "ERROR: file already exists"
		echo "'LICENSE.${FILE:?}'"
		echo ""
		exit 1
	}

	(
		echo "Copyright (c) 2017 Terasic Technologies Inc."
		echo "All rights reserved."
	) > "LICENSE.${FILE:?}"
done

echo "All license files created..."

declare -a IMAGE_ARRAY=($(echo [^L]*.png))
declare -a LICENSE_ARRAY=($(echo LICENSE.*.png))

[ "${#IMAGE_ARRAY[*]}" -eq "${#LICENSE_ARRAY[*]}" ] || {
	echo ""
	echo "ERROR: license file count does not equal image file count"
	echo "License files: ${#LICENSE_ARRAY[*]}"
	echo "  Image files: ${#IMAGE_ARRAY[*]}"
	echo ""
	exit 1
}

for INDEX in $(seq 0 $(expr ${#IMAGE_ARRAY[*]} - 1))
do
	[ "LICENSE.${IMAGE_ARRAY[${INDEX:?}]}" == \
	  "${LICENSE_ARRAY[${INDEX:?}]}" ] || {
		echo ""
		echo "ERROR: image file and license file mismatch"
		echo "License file: ${LICENSE_ARRAY[${INDEX:?}]}"
		echo "  Image file: ${IMAGE_ARRAY[${INDEX:?}]}"
		echo ""
		exit 1
	}
done

echo "All image files appear to have a license file..."

exit 0

