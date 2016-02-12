Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e28smtp01.in.ibm.com ([125.16.236.1]:37593 "EHLO
	e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbcBLSaA (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Fri, 12 Feb 2016 13:30:00 -0500
Received: from localhost
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Fri, 12 Feb 2016 23:59:56 +0530
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
	"Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: [PATCH v4 00/19] vfs: support for a common kernel file loader
Date: Fri, 12 Feb 2016 13:29:12 -0500
Message-Id: <1455301771-7703-1-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

For a while it was looked down upon to directly read files from Linux.
These days there exists a few mechanisms in the kernel that do just this
though to load a file into a local buffer. There are minor but important
checks differences on each, we should take all the best practices from
each of them, generalize them and make all places in the kernel that
read a file use it.[1]

One difference is the method for opening the file.  In some cases we
have a file, while in other cases we have a pathname or a file descriptor.

Another difference is the security hook calls, or lack of them.  In
some versions there is a post file read hook, while in others there
is a pre file read hook. 

This patch set attempts to resolve these differences.  It does not attempt
to merge the different methods of opening a file, but defines a single
common kernel file read function with two wrappers. In addition, as none
of the upstreamed LSMs define either a kernel_module_from_file or a
kernel_fw_from_file hook, this patch set removes these hooks and the
associated functions.  The ima_module_check() and ima_fw_from_file()
functions are renamed and called from the pre and post kernel_read_file
security functions respectively.

Changelog:
- First four IMA patches removed from this patch set.
- Cleaned up the kernel_read_file_id to ima_hooks enumeration mapping.
- Renamed the kexec IMA policy identifiers.
- Added missing include file for other architectures.
- Rebased on top of some of the "firmware_class: extensible firmware API"
patches posted by Luis.
- Removed the kernel_module_from_file and kernel_fw_from_file security
hooks and functions.
- Defined "kernel_read_file_id" enumeration, independently of "ima_hooks".
- Split patches for ease of review.

The latest version of these patches can be found in the next-kernel-read
branch of:
git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git

[1] Taken from Luis Rodriguez's wiki -
http://kernelnewbies.org/KernelProjects/common-kernel-loader

Mimi

Dmitry Kasatkin (2):
  ima: provide buffer hash calculation function
  ima: load policy using path

Kees Cook (1):
  firmware: clean up filesystem load exit path

Luis R. Rodriguez (2):
  firmware: simplify dev_*() print messages for generic helpers
  firmware: move completing fw into a helper

Mimi Zohar (14):
  vfs: define a generic function to read a file from the kernel
  vfs: define kernel_read_file_id enumeration
  ima: calculate the hash of a buffer using aynchronous hash(ahash)
  ima: define a new hook to measure and appraise a file already in
    memory
  vfs: define kernel_read_file_from_path
  firmware: replace call to fw_read_file_contents() with kernel version
  security: define kernel_read_file hook
  vfs: define kernel_copy_file_from_fd()
  module: replace copy_module_from_fd with kernel version
  ima: remove firmware and module specific cached status info
  kexec: replace call to copy_file_from_fd() with kernel version
  ima: support for kexec image and initramfs
  ima: measure and appraise the IMA policy itself
  ima: require signed IMA policy

 Documentation/ABI/testing/ima_policy  |   1 +
 drivers/base/firmware_class.c         |  74 +++++++--------------
 fs/exec.c                             |  95 +++++++++++++++++++++++++++
 include/linux/fs.h                    |  15 +++++
 include/linux/ima.h                   |  10 +--
 include/linux/lsm_hooks.h             |  35 +++++-----
 include/linux/security.h              |  16 +++--
 kernel/kexec_file.c                   |  73 +++------------------
 kernel/module.c                       |  68 +++-----------------
 security/integrity/iint.c             |   4 +-
 security/integrity/ima/ima.h          |  13 +++-
 security/integrity/ima/ima_api.c      |   6 +-
 security/integrity/ima/ima_appraise.c |  37 +++++------
 security/integrity/ima/ima_crypto.c   | 118 ++++++++++++++++++++++++++++++++++
 security/integrity/ima/ima_fs.c       |  51 ++++++++++++++-
 security/integrity/ima/ima_main.c     |  73 ++++++++++++++++-----
 security/integrity/ima/ima_policy.c   |  41 ++++++++++--
 security/integrity/integrity.h        |  15 ++---
 security/security.c                   |  32 ++++-----
 19 files changed, 499 insertions(+), 278 deletions(-)

-- 
2.1.0

